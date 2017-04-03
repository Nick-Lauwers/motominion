class ReplyMailer < ApplicationMailer

  def reply_received(reply)
    @reply = reply
    mail to: reply.question.user.email, subject: "You Received A Reply!"
  end
end
