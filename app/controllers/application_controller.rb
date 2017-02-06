# completed

class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  
    # Redirects to back, or to default url if back fails
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
        flash[:failure] = "Please log in."
        redirect_to login_url
      end
    end
end