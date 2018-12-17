# completed

class AccountActivationsController < ApplicationController

  def edit
    
    user = User.find_by(email: params[:email])
    
    if user && user.authenticated?(:activation, params[:id])
      # && !user.activated?
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to root_url
      
      # Rather than redirecting to rooturl, redirect to a page that asks if you
      # would like to login with a password; There will be a link to the reset
      # password path; Then, in the 
    
    # elsif user 
    #   # && user.authenticated?(:activation, params[:id])
    #   log_in user
    #   flash[:success] = "Welcome back!"
    #   redirect_to root_url
     
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end