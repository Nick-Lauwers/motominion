class RepliesController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      flash[:success] = "Reply created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def reply_params
      params.require(:reply).permit(:content, :comment_id)
    end
end