class BlogsController < ApplicationController
  
  before_action :logged_in_user,     except: [:index, :show]
  before_action :profile_pic_upload, only:   [:new]
  before_action :get_blog,           except: [:new, :create, :index]
  
  def new
    @blog = current_user.blogs.build
  end
  
  def create
    
    @blog = current_user.blogs.build(blog_params)
    
    if @blog.save
      flash[:success] = "Blog entry submitted"
      redirect_to @blog
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @blog.update(blog_params)
      flash[:success] = "Updates saved"
      redirect_to @blog
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def index
    @blogs = Blog.all
  end
  
  private
  
    def blog_params
      params.require(:blog).permit(:title, :content, :cover_photo)
    end
    
    # Before filters
    
    # Identifies blog id.
    def get_blog
      @blog = Blog.find(params[:id])
    end
end