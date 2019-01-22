# completed

class ConversationsController < ApplicationController

  before_action :logged_in_user,     only: [:create]
  before_action :profile_pic_upload, only: [:reveal_identity]

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
        
        if current_user.favorite_vehicles.exists?(vehicle: appointment.vehicle)

          current_user.
            favorite_vehicles.
            where(vehicle: appointment.vehicle).
            first.
            update_attribute(:is_test_drive, true)
        
        else
          
          current_user.favorites << appointment.vehicle
          
          current_user.
            favorite_vehicles.
            where(vehicle: appointment.vehicle).
            first.
            update_attribute(:is_test_drive, true)
        end
        
        @conversation.messages.create!(
          user:    current_user, 
          content: "Hi, " + 
                  @other.first_name + 
                  ". I recently noticed your motorcycle, " +
                  appointment.vehicle.listing_name +
                  ", and am interested in a test drive. Are you available on " +
                  appointment.date.strftime("%A, %d %b") + ", at " + 
                  appointment.date.strftime("%-l:%M%p") + "?"
        )
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
                                        
        AppointmentMailer.appointment_request(appointment).deliver_now
        AppointmentMailer.appointment_request_admin(appointment).deliver_now
      
      elsif conversation_params[:vehicle_inquiries_attributes].present?
        
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        vehicle_inquiry = @conversation.vehicle_inquiries.create!(
                            conversation_params[:vehicle_inquiries_attributes].
                            values.
                            first
                          )
        
        if current_user.first_name.blank?
          current_user.update_attributes(first_name: vehicle_inquiry.first_name)
        end
        
        if current_user.last_name.blank?
          current_user.update_attributes(last_name: vehicle_inquiry.last_name)
        end 
                          
        inquiry_booleans = [ vehicle_inquiry.price, 
                             vehicle_inquiry.special_offers,
                             vehicle_inquiry.availability,
                             vehicle_inquiry.condition,
                             vehicle_inquiry.vehicle_history,
                             vehicle_inquiry.test_drives ];
                             
        inquiry_strings = [ "pricing", "special offers", "availability",
                            "condition", "vehicle history", 
                            "scheduling a test drive" ];
                            
        string  = "";
        
        for i in 0..inquiry_booleans.count
          if inquiry_booleans[i] == true
            string = string + inquiry_strings[i] + "; "
          end
        end
        
        if vehicle_inquiry.price || vehicle_inquiry.special_offers ||
           vehicle_inquiry.availability || vehicle_inquiry.condition ||
           vehicle_inquiry.vehicle_history || vehicle_inquiry.test_drives
          message = @conversation.messages.create!(
                      user:    current_user, 
                      content: "Hi, " + 
                              @other.first_name + 
                              ". I recently noticed your motorcycle, " +
                              vehicle_inquiry.vehicle.listing_name + 
                              ", and have questions about: " +
                              string
                    )
        
        else
          message = @conversation.messages.create!(
                      user:    current_user, 
                      content: "Hi, " + 
                              @other.first_name + 
                              ". I recently noticed your motorcycle, " +
                              vehicle_inquiry.vehicle.listing_name + 
                              ", and am wondering if it is still available."
                    )
        end
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
        
        MessageMailer.message_received(message).deliver_now
        MessageMailer.message_received_admin(message).deliver_now
      end
      
    else
      
      @conversation = Conversation.create!(conversation_params)
      
      if conversation_params[:appointments_attributes].present?
      
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        appointment = @conversation.appointments.first
        
        if current_user.favorite_vehicles.exists?(vehicle: appointment.vehicle)

          current_user.
            favorite_vehicles.
            where(vehicle: appointment.vehicle).
            first.
            update_attribute(:is_test_drive, true)
        
        else
          
          current_user.favorites << appointment.vehicle
          
          current_user.
            favorite_vehicles.
            where(vehicle: appointment.vehicle).
            first.
            update_attribute(:is_test_drive, true)
        end
        
        # appointment = @conversation.appointments.create!(
        #                 conversation_params[:appointments_attributes].values.first
        #               )
        
        @conversation.messages.create!(
          user:    current_user, 
          content: "Hi, " + 
                   @other.first_name + 
                   ". I recently noticed your motorcycle, " +
                   appointment.vehicle.listing_name +
                   ", and am interested in a test drive. Are you available on " +
                   appointment.date.strftime("%A, %d %b") + ", at " + 
                   appointment.date.strftime("%-l:%M%p") + "?"
        )
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
                                        
        AppointmentMailer.appointment_request(appointment).deliver_now
        AppointmentMailer.appointment_request_admin(appointment).deliver_now
      
      elsif conversation_params[:vehicle_inquiries_attributes].present?
        
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        vehicle_inquiry = @conversation.vehicle_inquiries.create!(
                            conversation_params[:vehicle_inquiries_attributes].
                            values.
                            first
                          )
                          
        if current_user.first_name.blank?
          current_user.update_attributes(first_name: vehicle_inquiry.first_name)
        end
        
        if current_user.last_name.blank?
          current_user.update_attributes(last_name: vehicle_inquiry.last_name)
        end  
                          
        inquiry_booleans = [ vehicle_inquiry.price, 
                             vehicle_inquiry.special_offers,
                             vehicle_inquiry.availability,
                             vehicle_inquiry.condition,
                             vehicle_inquiry.vehicle_history,
                             vehicle_inquiry.test_drives ];
                             
        inquiry_strings = [ "pricing", "special offers", "availability",
                            "condition", "vehicle history", 
                            "scheduling a test drive" ];
                            
        string  = "";
        
        for i in 0..inquiry_booleans.count
          if inquiry_booleans[i] == true
            string = string + inquiry_strings[i] + "; "
          end
        end

        if vehicle_inquiry.price || vehicle_inquiry.special_offers ||
           vehicle_inquiry.availability || vehicle_inquiry.condition ||
           vehicle_inquiry.vehicle_history || vehicle_inquiry.test_drives
          message = @conversation.messages.create!(
                      user:    current_user, 
                      content: "Hi, " + 
                              @other.first_name + 
                              ". I recently noticed your motorcycle, " +
                              vehicle_inquiry.vehicle.listing_name + 
                              ", and have questions about: " +
                              string
                    )
        
        else
          message = @conversation.messages.create!(
                      user:    current_user, 
                      content: "Hi, " + 
                              @other.first_name + 
                              ". I recently noticed your motorcycle, " +
                              vehicle_inquiry.vehicle.listing_name + 
                              ", and am wondering if it is still available."
                    )
        end
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
        
        MessageMailer.message_received(message).deliver_now
        MessageMailer.message_received_admin(message).deliver_now
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
  
  def reveal_identity
    @conversation = Conversation.find(params[:id])
    @conversation.update_attribute(:is_sender_anonymous, false)
    flash[:success] = "Your identity is no longer hidden."
    redirect_to :back
  end
  
  def hide_identity
    @conversation = Conversation.find(params[:id])
    @conversation.update_attribute(:is_sender_anonymous, true)
    flash[:success] = "Your can now message anonymously."
    redirect_to :back
  end

  def export
    @conversation = Conversation.find(params[:id])
    ConversationMailer.export(@conversation, current_user).deliver_now
    flash[:success] = "Check your email for a transcript of this conversation."
    redirect_to :back 
  end
  
  private
  
    def conversation_params
      params.require(:conversation).permit(:sender_id, :recipient_id, 
                                           :next_contributor_id, 
                                           :sender_archived, 
                                           :recipient_archived,
                                           :is_sender_anonymous,
                                           :sender_last_viewed_at, 
                                           :recipient_last_viewed_at,
                                           :latest_message_read,
                                           appointments_attributes: 
                                           [:date, :status, :seller_id, 
                                            :buyer_id, :vehicle_id],
                                           vehicle_inquiries_attributes: 
                                           [:price, :special_offers, 
                                            :availability, :condition, 
                                            :vehicle_history, :test_drives,
                                            :user_id, :vehicle_id, :first_name,
                                            :last_name, :email])
    end
end

# ensure that user is logged in