class PersonalizedSearchesController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_personalized_search, except: [:new, :create, :incomplete]
  
  def new
    @personalized_search = PersonalizedSearch.new
  end
  
  def create
    
    @personalized_search = current_user.build_personalized_search personalized_search_params
    
    if @personalized_search.save
      if params[:redirect_to_show].present?
        redirect_to @personalized_search
      else
        redirect_to location_personalized_search_path(@personalized_search)
      end
    else
      # render 'new'
    end
  end
  
  def edit
    # @user = User.find(current_user.id)
  end
  
  def update
    
    if @personalized_search.update(personalized_search_params)
      
      if params[:redirect_location].present?
        redirect_to params[:redirect_location]
      else
        redirect_to @personalized_search
      end
      
    else
      flash[:failure]  = "Please try again."
      redirect_to :back
    end
  end
  
  def show
  end
  
  def start
    @personalized_search = PersonalizedSearch.new
  end
  
  def style
  end
  
  def price
  end
  
  def mileage
  end
  
  def year
  end
  
  def installed_options
  end
  
  private
    
    def personalized_search_params
      params.require(:personalized_search).permit(:is_classic_vintage, 
        :is_cafe_racer, :is_cruiser, :is_dual_sport, :is_mini_pocket, :is_moped, 
        :is_sportbike, :is_standard, :is_touring, :is_trike, :cruise_control,
        :am_fm, :cb_radio, :navigation_system, :heated_seats, :alarm_system,
        :saddlebags, :trunk, :tow_hitch, :cycle_cover, :price, :mileage, :year,
        :is_one_seat, :is_two_seats, :is_beginner, :is_intermediate, 
        :is_advanced, :zip_code, :max_distance)
    end
    
    # Before filters
    
    # Identifies personalized search id.
    def get_personalized_search
      @personalized_search = PersonalizedSearch.
                               find_by(user_id: current_user.id)
      # @personalized_search = current_user.personalized_search
    end
end