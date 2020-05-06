class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :get_filterrific
  after_filter :user_activity

  private
  
    # Redirects to back, or to default url if back fails.
    def redirect_to_back_or_default(default = root_url)
      
      if request.env["HTTP_REFERER"].present? and 
         request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
        
      else
        redirect_to default
      end
    end
  
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        # flash[:failure] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms a private buyer / seller.
    def private_buyer
      unless private_buyer?
        store_location
        flash[:failure] = "Access restricted to private buyers; Dealers are unable to generate personalized results."
        redirect_to_back_or_default
      end
    end
    
    # Confirms profile pic upload.
    def profile_pic_upload
      unless profile_pic?
        store_location
        redirect_to profile_pic_user_path(current_user)
      end
    end
    
    # Confirms that current user is club admin.
    def club_admin
      unless current_user.
               memberships.
               where(club_id: @club.id, admin: true).
               exists?
        flash[:failure] = "Access restricted."
        redirect_to_back_or_default
      end
    end
    
    # Updates user if online.
    def user_activity
      current_user.try :touch
    end
    
    # Gets filterrific
    def get_filterrific
      
      @filterrific = initialize_filterrific(
      
        Vehicle,
        params[:filterrific],
        
        select_options: {
          sorted_by:             Vehicle.options_for_sorted_by
        },
        
        persistence_id: false,
        default_filter_params: {},
        
        available_filters: [
          :with_vehicle_make_id, 
          :with_vehicle_model_id,
          :with_city,
          :with_condition,
          :with_year_gte,
          :with_actual_price_lte,
          :with_mileage_numeric_lte,
          :with_body_style
        ],
      ) or return
    end
end