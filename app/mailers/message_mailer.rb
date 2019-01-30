class MessageMailer < ApplicationMailer

  def message_received(message)
    
    @message      = message.content
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    @conversation = message.conversation
    
    mail to: @recipient.email, subject: "#{Emoji.find_by_alias("bell").raw} #{@sender.first_name} sent you a message!"
  end
  
  def message_received_admin(message)
    
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    @conversation = message.conversation
    
    mail to: "nlauwers@motominion.com", subject: "#{Emoji.find_by_alias("bell").raw} #{@recipient.first_name} sent #{@sender.first_name} a message!"
  end
end