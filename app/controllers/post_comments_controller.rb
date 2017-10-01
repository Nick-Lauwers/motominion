class PostCommentsController < ApplicationController
  
  before_action :logged_in_user
  before_action :profile_pic_upload, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.create(params.require(:post_comment).permit(:content))
    @post_comment.user_id = current_user.id if current_user
    @post_comment.save
    
    if @post_comment.save
      flash[:success] = "Comment posted"
      redirect_to post_path(@post)
    else
      flash[:failure] = "Be sure to include a comment."
      redirect_to @post
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])
    
    if @post_comment.update(params.require(:post_comment).permit(:content))
      flash[:success] = "Updates saved"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])
    @post_comment.destroy
    flash[:success] = "Comment removed"
    redirect_to post_path(@post)
  end
end