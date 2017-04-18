# destroy redirect
# authenticate_user

class PostsController < ApplicationController
  
  before_action :logged_in_user, except: [:index, :show, :search, :autocomplete]
  before_action :find_post,      only:   [:show, :edit, :update, :destroy, 
                                          :like, :unlike]
  
  def index
    
    @top_posts        = Post.order(
                          cached_votes_up: :desc, 
                          created_at:      :desc
                        ).limit(10)
                        
    @recent_posts     = Post.order(created_at: :desc).limit(10)
    
    @unanswered_posts = Post.
                        includes(:responses).
                        where('responses.id IS NULL').
                        references(:responses).
                        order(created_at: :desc).
                        limit(10)
                        # .
                        # paginate(page: params[:page], per_page: 2)
                        
    @top_contributors = User.joins(:posts).group('users.id').order('sum(posts.cached_votes_up) desc')\
    
    # respond_to do |format|
    #   format.html # index.html.erb
    #   ajax_respond format, :section_id => "page"
    # end
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
  
  def search
    
    if params[:post].present?
      
      @posts = Post.search params[:post],
                           page: params[:page], 
                           per_page: 10

    else
      @posts = Post.all.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def autocomplete
    render json: Post.search(params[:post], autocomplete: false, limit: 10).map do |post|
      { title: post.title, value: post.id }
    end
  end
  
  private
  
    def find_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
end