# what to do if comment saves and if comment fails to save

class QuestionsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @question = current_user.questions.build(question_params)
    # if @question.save
    #   respond_to do |format|
    #     format.js
    #   end
    # end
    
    # respond_to do |format|
    #   format.html { redirect_to @question.vehicle }
    #   format.js
    # end
    
    if @question.save
      flash[:success] = "Question created!"
      redirect_to @question.vehicle
    else
      redirect_to request.referrer || root_url
    end
  end

  def destroy
  end

  private

    def question_params
      params.require(:question).permit(:title, :content, :vehicle_id)
    end
end