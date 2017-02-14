# questionable

class RepliesController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    
    @reply = current_user.replies.build(reply_params)
    
    if @reply.save
      flash[:success] = "Reply created!"
      redirect_to @reply.question.vehicle
    else
      redirect_to request.referrer || root_url    
    end
  end

  def destroy
  end

  private

    def reply_params
      params.require(:reply).permit(:content, :question_id)
    end
end