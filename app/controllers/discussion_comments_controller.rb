class DiscussionCommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @discussion_comment = @discussion.discussion_comments.create(params.require(:discussion_comment).permit(:comment))
    @discussion_comment.user_id = current_user.id if current_user
    @discussion_comment.save
    
    if @discussion_comment.save
      flash[:success] = "Comment posted"
      redirect_to discussion_path(@discussion)
    else
      flash[:failure] = "Be sure to include a comment."
      redirect_to @discussion
    end
  end
  
  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @discussion_comment = @discussion.discussion_comments.find(params[:id])
  end
  
  def update
    @discussion = Discussion.find(params[:discussion_id])
    @discussion_comment = @discussion.discussion_comments.find(params[:id])
    
    if @discussion_comment.update(params.require(:discussion_comment).permit(:comment))
      flash[:success] = "Updates saved"
      redirect_to discussion_path(@discussion)
    else
      render 'edit'
    end
  end
  
  def destroy
    @discussion = Discussion.find(params[:discussion_id])
    @discussion_comment = @discussion.discussion_comments.find(params[:id])
    @discussion_comment.destroy
    flash[:success] = "Comment removed"
    redirect_to discussion_path(@discussion)
  end
end