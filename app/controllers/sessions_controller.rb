# completed

class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    @user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && @user.authenticate(params[:session][:password])
      
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or dashboard_path
        
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      
    else
      flash.now[:failure] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def create_social
    @token = params[:invitation_token]
    @user = User.from_omniauth(env['omniauth.auth'])
    
    if @token != nil
      org = Invitation.find_by_token(@token).club
      @user.clubs.push(org)
    end
    
    log_in @user
    redirect_back_or dashboard_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end