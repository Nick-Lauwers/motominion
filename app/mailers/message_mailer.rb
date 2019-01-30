class MessageMailer < ApplicationMailer

  def message_received(message)
    
    @message      = message.content
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    @conversation = message.conversation
    
    if @sender.dealership.present?
      mail to: @recipient.email, 
      subject: "#{Emoji.find_by_alias("bell").raw} #{@sender.dealership.dealership_name} sent you a message!"
    
    else
      mail to: @recipient.email, 
      subject: "#{Emoji.find_by_alias("bell").raw} #{@sender.first_name} sent you a message!"
    end
  end
  
  def message_received_admin(message)
    
    @message      = message.content
    @recipient    = message.user == message.conversation.sender ? message.conversation.recipient : message.conversation.sender
    @sender       = message.user
    
    if @sender.dealership.present?
      mail to: "nlauwers@motominion.com", 
      subject: "#{Emoji.find_by_alias("bell").raw} #{@sender.dealership.dealership_name} sent a message!"
    else 
      mail to: "nlauwers@motominion.com", 
      subject: "#{Emoji.find_by_alias("bell").raw} #{@sender.full_name} sent a message!"
    end
  end
end