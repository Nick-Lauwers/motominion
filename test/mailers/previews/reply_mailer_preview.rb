# Preview all emails at http://localhost:3000/rails/mailers/reply_mailer
class ReplyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reply_mailer/reply_received
  def reply_received
    reply = Reply.first
    ReplyMailer.reply_received(reply)
  end

end
