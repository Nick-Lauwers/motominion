# completed

class ConversationsController < ApplicationController

  before_action :logged_in_user,     only: [:create]
  before_action :profile_pic_upload, only: [:create]

  def index
    
    @conversations_primary = 
      Conversation.includes(:messages).where(
        ['sender_id = ? AND sender_archived = ?', current_user.id, false]).
      or(
        ['recipient_id = ? AND recipient_archived = ?', current_user.id, false]
      ).
      where.not(messages: { id: nil })

    @conversations_archived = 
      Conversation.includes(:messages).where(
        ['sender_id = ? AND sender_archived = ?', current_user.id, true]).
      or(
        ['recipient_id = ? AND recipient_archived = ?', current_user.id, true]
      ).
      where.not(messages: { id: nil })
  end
  
  def create
    
    if Conversation.between(
        conversation_params[:sender_id], conversation_params[:recipient_id]
      ).present?
      
      @conversation = Conversation.between(
                        conversation_params[:sender_id], 
                        conversation_params[:recipient_id]
                      ).first
                      
      if conversation_params[:appointments_attributes].present?
        
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        appointment = @conversation.appointments.create!(
                        conversation_params[:appointments_attributes].values.first
                      )
        
        @conversation.messages.create!(
          user:    current_user, 
          content: "Hi, " + 
                  @other.first_name + 
                  ". I recently noticed your vehicle, " +
                  appointment.vehicle.listing_name +
                  ", and am interested in a test drive. Are you available on " +
                  appointment.date.strftime("%A, %d %b") + ", at " + 
                  appointment.date.strftime("%-l:%M%p") + "?"
        )
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
                                        
        AppointmentMailer.appointment_request(appointment).deliver_now
      end
      
    else
      
      @conversation = Conversation.create(conversation_params)
      
      if conversation_params[:appointments_attributes].present?
      
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        appointment = @conversation.appointments.first
        
        # appointment = @conversation.appointments.create!(
        #                 conversation_params[:appointments_attributes].values.first
        #               )
        
        @conversation.messages.create!(
          user:    current_user, 
          content: "Hi, " + 
                   @other.first_name + 
                   ". I recently noticed your vehicle, " +
                   appointment.vehicle.listing_name +
                   ", and am interested in a test drive. Are you available on " +
                   appointment.date.strftime("%A, %d %b") + ", at " + 
                   appointment.date.strftime("%-l:%M%p") + "?"
        )
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
                                        
        AppointmentMailer.appointment_request(appointment).deliver_now
      end
    end
    
    if conversation_params[:appointments_attributes].present?
      flash[:success] = "Test drive request sent! Feel free to send the owner a 
                         message."
    end
    
    redirect_to conversation_messages_path(@conversation)
  end
  
  def destroy
    @conversation.destroy
    flash[:success] = "Conversation deleted"
    redirect_to conversations_path
  end
  
  def archive
    
    @conversation = Conversation.find(params[:id])
    
    if (current_user.id == @conversation.sender_id && 
        @conversation.sender_archived == false)
      @conversation.update_attribute(:sender_archived, true)
      
    elsif (current_user.id == @conversation.recipient_id && 
           @conversation.recipient_archived == false)
      @conversation.update_attribute(:recipient_archived, true)
      
    elsif (current_user.id == @conversation.sender_id && 
           @conversation.sender_archived == true)
      @conversation.update_attribute(:sender_archived, false)
      
    else
      @conversation.update_attribute(:recipient_archived, false)
    end
    
    redirect_to :back
  end
  
  private
  
    def conversation_params
      params.require(:conversation).permit(:sender_id, :recipient_id, 
                                           :next_contributor_id, 
                                           :sender_archived, 
                                           :recipient_archived,
                                           :sender_last_viewed_at, 
                                           :recipient_last_viewed_at,
                                           appointments_attributes: 
                                           [:date, :status, :seller_id, 
                                            :buyer_id, :vehicle_id])
    end
end

# ensure that user is logged in