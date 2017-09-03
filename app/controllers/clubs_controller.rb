class ClubsController < ApplicationController
  
  before_action :logged_in_user, except: [:index, :show, :search, :autocomplete]
  before_action :get_club,       only:   [:edit, :update, :show, :join]
  
  def new
    @club = Club.new
  end
  
  def create
    
    @club = Club.new(club_params)
    @club.memberships.build(user: current_user, admin: true)

    if @club.save
      flash[:success] = "Club created"
      redirect_to @club
    
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    
    if @club.update(club_params)
      
      # if params[:images]
      #   params[:images].each do |image|
      #     @vehicle.photos.create(image: image)
      #   end
      # end
      
      flash[:success] = "Updates saved."
    
    else
      flash[:danger] = "Update failed."
      # render 'edit'
    end
    
    redirect_to @club
  end
  
  def index
    @clubs = Club.first(10)
  end
  
  def show
    @posts = Post.where(club_id: @club.id)
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
  
  def search
  
    if params[:city].present?
      
      @clubs = Club.search params[:city],
                           page: params[:page], 
                           per_page: 10

    else
      @clubs = Club.all.paginate(page: params[:page], per_page: 10)
    end
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
end