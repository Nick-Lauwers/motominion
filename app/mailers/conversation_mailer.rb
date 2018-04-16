class ConversationMailer < ApplicationMailer
  
  def export(conversation, current_user)
    
    @messages  = conversation.messages
    @user      = current_user
    @other     = current_user == conversation.sender ? conversation.recipient : conversation.sender
    
    mail to: @user.email, subject: "Motominion Chat with"
  end
end