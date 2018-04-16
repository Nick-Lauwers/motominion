# questionable

class AnswersController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    
    @answer = current_user.answers.build(answer_params)
    
    if @answer.save
      AnswerMailer.answer_received(@answer).deliver_now
      flash[:success] = "Answer posted!"
      redirect_to @answer.question.vehicle
    else
      redirect_to request.referrer || root_url    
    end
  end

  def destroy
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :question_id, :is_anonymous)
    end
end