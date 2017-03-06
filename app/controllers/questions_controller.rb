# completed

class QuestionsController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :create, :destroy]
  
  def index
    @conversations = Conversation.involving(current_user)
    @vehicles      = current_user.vehicles
    @questions     = Question.where(vehicle: current_user.vehicles)
    @reply         = current_user.replies.build
    
    @questions.each do |question|
      question.update_attribute(:read_at, Time.now)
    end
  end

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
      params.require(:question).permit(:title, :content, :read_at, :vehicle_id)
    end
end