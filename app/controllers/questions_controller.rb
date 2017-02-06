# completed

class QuestionsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    
    @question = current_user.questions.build(question_params)
    
    if @question.save
      flash[:success] = "Question created!"
      redirect_to @question.vehicle
    else
      flash[:failure] = "Please include all details."
      redirect_to @question.vehicle
    end
  end

  def destroy
  end

  private

    def question_params
      params.require(:question).permit(:title, :content, :vehicle_id)
    end
end