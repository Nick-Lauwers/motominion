class AnswerMailer < ApplicationMailer

  def answer_received(answer)
    @answer = answer
    mail to: answer.question.user.email, subject: "You Received An Answer!"
  end
end
