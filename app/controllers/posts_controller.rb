class PostsController < ApplicationController
  
  before_action :logged_in_user,     except: [:index, :show]
  before_action :get_post,           only:   [:show, :edit, :update, :destroy,
                                              :like, :unlike]
  before_action :profile_pic_upload, only:   [:new]
  
  def index
    @posts = @club.posts
  end
  
  def show
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "Post submitted"
      redirect_to @post
    else
      # check this one
      # redirect_to new_post_path(club_id: @post.club_id)
      redirect_to :back
      flash[:failure] = "Be sure to include a photo and a caption."
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = "Updates saved"
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to discussions_path
    # Does not redirect to correct place if in clubs or in vehicle makes
  end
  
  def like
    
    @post.liked_by current_user
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render layout: false }
    end
  end
  
  def unlike

    @post.unliked_by current_user
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render layout: false }
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:content, :vehicle_make_id, 
                                   :vehicle_model_id, :photo, :club_id)
    end
    
    # Before filters
    
    # Identifies post id.
    def get_post
      @post = Post.find(params[:id])
    end
end