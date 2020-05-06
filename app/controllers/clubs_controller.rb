class ClubsController < ApplicationController
  
  before_action :logged_in_user,     except: [:index, :posts, :discussions, 
                                              :autocomplete]
  before_action :get_club,           only:   [:edit, :update, :posts, 
                                              :discussions, :join]
  before_action :profile_pic_upload, only:   [:new]
  before_action :club_admin,         only:   [:edit]
  before_action :invited_user,       only:   [:join]
  
  def new
    @club = Club.new
  end
  
  def create
    
    @club = Club.new(club_params)
    @club.memberships.build(user: current_user, admin: true)

    if @club.save
      flash[:success] = "Club created"
      redirect_to posts_club_path(@club)
    
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    
    if @club.update(club_params)
      flash[:success] = "Updates saved."
    
    else
      flash[:danger] = "Update failed."
    end
    
    redirect_to posts_club_path(@club)
  end
  
  def index
    
    if params[:city].present?
      
      @clubs = Club.search params[:city],
                           page: params[:page], 
                           per_page: 10

    else
      @clubs = Club.all.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def posts
  end
  
  def discussions
    @discussions = @club.discussions
  end
  
  def join
    
    if current_user.memberships.where(club_id: @club.id).exists?
      flash[:failure] = "You are already a member of #{ @club.name }."
    
    else
      current_user.memberships << @club.memberships
      flash[:success] = "You are now a member of #{ @club.name }!"
    end
    
    redirect_to :back
  end

  def autocomplete
    render json: Club.search(params[:club], autocomplete: false, limit: 10).map do |club|
      { city: club.city, value: club.id }
    end
  end

  private
  
    def club_params
      params.require(:club).permit(:name, :description, :city, :state, 
                                   :cover_photo)
    end
    
    # Before filters
    
    # Identifies club id.
    def get_club
      @club = Club.find(params[:id])
    end
    
    # Confirms an invited user.
    def invited_user
      unless Invitation.where(email: current_user.email).exists?
        flash[:failure] = "Access restricted."
        redirect_to_back_or_default
      end
    end
end