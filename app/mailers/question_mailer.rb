class QuestionMailer < ApplicationMailer

  def question_received(question)
    @question = question
    mail to: question.vehicle.user.email, subject: "You Received A Question!"
  end
end
