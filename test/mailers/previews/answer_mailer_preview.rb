# Preview all emails at http://localhost:3000/rails/mailers/reply_mailer
class AnswerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reply_mailer/reply_received
  def answer_received
    answer = Answer.first
    AnswerMailer.answer_received(answer)
  end

end
