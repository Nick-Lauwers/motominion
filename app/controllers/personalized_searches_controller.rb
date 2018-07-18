class PersonalizedSearchesController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_personalized_search, except: [:new, :create, :incomplete]
  
  def new
    @personalized_search = PersonalizedSearch.new
  end
  
  def create
    
    @personalized_search = current_user.build_personalized_search personalized_search_params
    
    if @personalized_search.save
      redirect_to price_personalized_search_path(@personalized_search)
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
  
  def price
    

    # if @personalized_search.save
    #   redirect_to mileage_user_personalized_search_path
    # else
    #   # render 'new'
    # end
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
        :is_cruiser, :is_dual_sport, :is_mini_pocket, :is_moped, 
        :is_sportbike, :is_standard, :is_touring, :is_trike, :cruise_control,
        :am_fm, :cb_radio, :navigation_system, :heated_seats, :alarm_system,
        :saddlebags, :trunk, :tow_hitchm, :cycle_cover, :price, :mileage, :year)
    end
    
    # Before filters
    
    # Identifies personalized search id.
    def get_personalized_search
      @personalized_search = PersonalizedSearch.
                               find_by(user_id: current_user.id)
      # @personalized_search = current_user.personalized_search
    end
end