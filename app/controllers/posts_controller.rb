# destroy redirect
# authenticate_user

class PostsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :find_post,      only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 10)
  end
  
  def show
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "Comment posted"
      redirect_to @post
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  private
  
    def find_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
end