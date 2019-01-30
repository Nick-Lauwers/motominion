# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/message_mailer/message_received
  def message_received
    message = Message.first
    MessageMailer.message_received(message)
  end
  
  # Preview this email at http://localhost:3000/rails/mailers/message_mailer/message_received_admin
  def message_received_admin
    message = Message.first
    MessageMailer.message_received_admin(message)
  end
end
