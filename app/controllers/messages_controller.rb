# questionable

class MessagesController < ApplicationController
  
  before_action :set_conversation
  before_action :logged_in_user
  
  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
      
      if @conversation.next_contributor_id == current_user.id
        @conversation.update_attribute(:latest_message_read, true)
        @conversation.save
      end
      
      # if @messages.exists? 
      #   if @conversation.messages.last.user_id == @other.id
      #     @conversation.update_attribute(:latest_message_read, true)
      #     @conversation.save
      #   end
      # end
      
      # if @messages.last.recipient_id == current_user.id
      #   @messages.where(read_at: nil).each do |message|
      #     message.update_attributes(read_at: Time.now)
      #     message.save
      #   end
      # end

      # def show
      #     @message = Message.find(params[:id])
      #     if @message.recipient_id == current_user.id
      #       @message.update_attributes(:read_at => Time.now)
      #     end
      #     respond_to do |format|
      #       format.html # show.html.erb
      #       format.xml  { render :xml => @message }
      #     end
      #   end

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