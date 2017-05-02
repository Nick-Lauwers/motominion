# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/question_mailer/question_received
  def question_received
    question = Question.first
    QuestionMailer.question_received(question)
  end

end