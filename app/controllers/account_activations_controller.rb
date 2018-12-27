# completed

class AccountActivationsController < ApplicationController

  def edit
    
    user = User.find_by(email: params[:email])
    
    if user && user.authenticated?(:activation, params[:id])

      if !user.activated?
        user.activate
      end
      
      log_in user
      
      if user.first_name.present?
        flash[:success] = "Welcome back, #{user.first_name}! If you would like 
                           to login using a password rather than through email,
                           set up your password 
                           #{view_context.link_to("here", 
                                                  edit_user_path(current_user))}."
      else
        flash[:success] = "Welcome back! If you would like to login using a 
                           password rather than through email, set up your 
                           password 
                           #{view_context.link_to("here", 
                                                  edit_user_path(current_user))}."
      end
      
      redirect_to root_url
      
      # Rather than redirecting to rooturl, redirect to a page that asks if you
      # would like to login with a password; There will be a link to the reset
      # password path; Then, in the 
     
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end