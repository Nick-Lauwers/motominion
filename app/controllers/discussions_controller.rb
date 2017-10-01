# destroy redirect
# authenticate_user

class DiscussionsController < ApplicationController
  
  before_action :logged_in_user,     except: [:index, :show, :search, 
                                              :autocomplete]
  before_action :profile_pic_upload, only:   [:new]
  before_action :get_discussion,     only:   [:show, :edit, :update, :destroy, 
                                              :like, :unlike]
  
  def index
    
    @top_discussions        = Discussion.
                                where("club_id IS NULL OR vehicle_make_id IS NOT NULL").
                                order(cached_votes_up: :desc, created_at: :desc).
                                limit(10)
                        
    @recent_discussions     = Discussion.
                                where("club_id IS NULL OR vehicle_make_id IS NOT NULL").
                                order(created_at: :desc).
                                limit(10)
    
    @unanswered_discussions = Discussion.
                                includes(:discussion_comments).
                                where("club_id IS NULL OR vehicle_make_id IS NOT NULL").
                                where("discussion_comments.id IS NULL").
                                references(:discussion_comments).
                                order(created_at: :desc).
                                limit(10)
                                # .
                                # paginate(page: params[:page], per_page: 2)
                        
    @top_contributors = User.
                          joins(:discussions).
                          group('users.id').
                          order('sum(discussions.cached_votes_up) desc', 
                                created_at: :asc).
                          limit(5)
    
    # respond_to do |format|
    #   format.html # index.html.erb
    #   ajax_respond format, :section_id => "page"
    # end
  end
  
  def show
  end
  
  def new
    @discussion = current_user.discussions.build
  end
  
  def create
    @discussion = current_user.discussions.build(discussion_params)
    
    if @discussion.save
      flash[:success] = "Discussion topic posted"
      redirect_to @discussion
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @discussion.update(discussion_params)
      flash[:success] = "Updates saved"
      redirect_to @discussion
    else
      render 'edit'
    end
  end
  
  def destroy
    @discussion.destroy
    flash[:success] = "Discussion deleted"
    redirect_to discussions_path
    # Does not redirect to correct place if in clubs or in vehicle makes
  end
  
  def like
    
    @discussion.liked_by current_user
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render layout: false }
    end
  end
  
  def unlike

    @discussion.unliked_by current_user
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render layout: false }
    end
  end
  
  def search
    
    if params[:discussion].present?
      
      @discussions = Discussion.search params[:discussion],
                                       page: params[:page], 
                                       per_page: 10

    else
      @discussions = Discussion.all.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def autocomplete
    render json: Discussion.search(params[:discussion], autocomplete: false, limit: 10).map do |discussion|
      { title: discussion.title, value: discussion.id }
    end
  end
  
  private
  
    def discussion_params
      params.require(:discussion).permit(:title, :content, :vehicle_make_id, 
                                         :vehicle_model_id, :club_id)
    end
  
    # Before filters
    
    # Identifies discussion id.
    def get_discussion
      @discussion = Discussion.find(params[:id])
    end
end