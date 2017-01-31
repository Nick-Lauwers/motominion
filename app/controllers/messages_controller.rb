class MessagesController < ApplicationController
  before_action :set_conversation
  
  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "Access denied"
    end
  end
  
  def create
    @message  = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")
    
    if @message.save
      respond_to do |format|
        format.js
      end
    end
  end
  
  def accept
    appointment = @conversation.appointments.where(status: 'pending').first
    appointment.update_attribute(:status, 'accepted')
    AppointmentMailer.appointment_accepted(appointment).deliver_now
    flash[:success] = "Test drive accepted!"
    redirect_to :back
  end
  
  def decline
    appointment = @conversation.appointments.where(status: 'pending').first
    appointment.update_attribute(:status, 'declined')
    AppointmentMailer.appointment_declined(appointment).deliver_now
    flash[:failure] = "Test drive declined."
    redirect_to :back
  end

  private
  
    def message_params
      params.require(:message).permit(:content, :user_id)
    end
      
    # Before filters
    
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end