class ResponsesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @response = @post.responses.create(params[:response].permit(:comment))
    @response.user_id = current_user.id if current_user
    @response.save
    
    if @response.save
      flash[:success] = "Comment posted"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
    @response = @post.responses.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @response = @post.responses.find(params[:id])
    
    if @response.update(params[:response].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @response = @post.responses.find(params[:id])
    @response.destroy
    redirect_to post_path(@post)
  end
end