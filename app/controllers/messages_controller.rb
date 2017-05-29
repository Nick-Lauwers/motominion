# questionable

class MessagesController < ApplicationController
  
  before_action :set_conversation
  before_action :logged_in_user
  
  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      
      @messages = @conversation.messages.order("created_at DESC")
      @messages_by_day = @messages.group_by { |message| message.created_at.to_date }
      
      if (current_user.id == @conversation.sender_id)
        @conversation.update_attribute(:sender_last_viewed_at, Time.now)
      else
        @conversation.update_attribute(:recipient_last_viewed_at, Time.now)
      end
      
      if @conversation.next_contributor_id == current_user.id
        @conversation.update_attribute(:latest_message_read, true)
        @conversation.save
      end
      
    else
      redirect_to conversations_path, alert: "Access denied"
    end
  end
  
  def create
    @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
    @message  = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")
    
    if @message.save
      MessageMailer.message_received(@message).deliver_now
      @conversation.update_attributes(next_contributor_id: @other.id,
                                      latest_message_read: false)
      @conversation.save
      respond_to do |format|
        format.js
      end
    end
  end

  private
  
    def message_params
      params.require(:message).permit(:content, :user_id)
    end
      
    # Before filters
    
    # Identifies conversation id.
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end