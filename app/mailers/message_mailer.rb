class MessageMailer < ApplicationMailer

  def message_received(message)
    
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    @conversation = message.conversation
    
    mail to: @recipient.email, subject: "You Received A Message!"
  end
  
  def message_received_admin(message)
    
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    @conversation = message.conversation
    
    mail to: "nlauwers@motominion.com", subject: "You Received A Message!"
  end
end