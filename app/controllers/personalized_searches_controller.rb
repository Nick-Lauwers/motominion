class PersonalizedSearchesController < ApplicationController
  
  before_action :logged_in_user
  before_action :private_buyer
  before_action :get_personalized_search, except: [:new, :create, :incomplete,
                                                   :start, :survey]
  
  def new
    @personalized_search = PersonalizedSearch.new
  end
  
  def create
    
    @personalized_search = current_user.build_personalized_search personalized_search_params
    
    if @personalized_search.save
      if params[:redirect_to_show].present?
        redirect_to @personalized_search
      else
        redirect_to manufacturer_personalized_search_path(@personalized_search)
      end
    else
    end
  end
  
  def edit
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
  
  def survey
    @personalized_search = PersonalizedSearch.new
  end
  
  def manufacturer
  end
  
  def all_manufacturers
    
    @personalized_search.
      update_attributes(is_aprilia: true, is_bmw: true, is_can_am: true, 
                        is_ducati: true, is_harley_davidson: true, 
                        is_honda: true, is_indian: true, is_ktm: true, 
                        is_kawasaki: true, is_kymco: true, is_suzuki: true, 
                        is_triumph: true, is_vespa: true, is_victory: true, 
                        is_yamaha: true)
      
    redirect_to location_personalized_search_path(@personalized_search)
  end
  
  private
    
    def personalized_search_params
      params.require(:personalized_search).permit(:is_classic_vintage, 
        :is_cafe_racer, :is_cruiser, :is_dual_sport, :is_mini_pocket, :is_moped, 
        :is_sportbike, :is_standard, :is_touring, :is_trike, :cruise_control,
        :am_fm, :cb_radio, :navigation_system, :heated_seats, :alarm_system,
        :saddlebags, :trunk, :tow_hitch, :cycle_cover, :price, :mileage, :year,
        :is_one_seat, :is_two_seats, :is_beginner, :is_intermediate, 
        :is_advanced, :zip_code, :max_distance, :is_aprilia, :is_bmw,
        :is_can_am, :is_ducati, :is_harley_davidson, :is_honda, :is_indian,
        :is_ktm, :is_kawasaki, :is_kymco, :is_suzuki, :is_triumph, :is_vespa,
        :is_victory, :is_yamaha)
    end
    
    # Before filters
    
    # Identifies personalized search id.
    def get_personalized_search
      @personalized_search = PersonalizedSearch.
                               find_by(user_id: current_user.id)
    end
end