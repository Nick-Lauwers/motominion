class ClubsController < ApplicationController
  
  before_action :logged_in_user, except: [:index, :show, :overview]
  before_action :get_club,       only:   [:show]
  
  def new
    @club = Club.new
  end
  
  def create
    
    @club = Club.new(club_params)
    @club.memberships.build(user: current_user, admin: true)

    if @club.save
      flash[:success] = "Club created"
      redirect_to clubs_overview_path
    
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def index
    @clubs = Club.all
  end
  
  def show
  end
  
  def overview
    @clubs = Club.all
  end
  
  private
  
    def club_params
      params.require(:club).permit(:name, :description, :cover_photo)
    end
    
    # Before filters
    
    # Identifies club id.
    def get_club
      @club = Club.find(params[:id])
    end
end