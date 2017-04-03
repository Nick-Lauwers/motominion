# completed

class ConversationsController < ApplicationController

  before_action :logged_in_user,  only: [:create]

  def index
    
    @conversations_primary  = Conversation.where(
      ['sender_id = ? AND sender_archived = ?', current_user.id, false] || 
      ['recipient_id = ? AND recipient_archived = ?', current_user.id, false]
    )
    
    @conversations_archived = Conversation.where(
      ['sender_id = ? AND sender_archived = ?', current_user.id, true] || 
      ['recipient_id = ? AND recipient_archived = ?', current_user.id, true]
    )
    
    # @conversations = Conversation.involving(current_user)
    # @vehicles      = current_user.vehicles
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
        
        @conversation.appointments.create(
          conversation_params[:appointments_attributes].values.first
        )
        
        @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
        
        @conversation.update_attributes(next_contributor_id: @other.id, 
                                        latest_message_read: false)
      end
      
    else
      
      @conversation = Conversation.create(conversation_params)
      
      @conversation.appointments.build
      
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      
      @conversation.update_attributes(next_contributor_id: @other.id, 
                                      latest_message_read: false)
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
                                           :sender_archived, 
                                           :recipient_archived,
                                           appointments_attributes: 
                                           [:date, :status, :seller_id, 
                                            :buyer_id, :vehicle_id])
    end
end

# ensure that user is logged in