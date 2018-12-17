# completed

class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    @user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && @user.password_digest.present? && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or dashboard_path
    
    elsif @user && @user.password_digest.present?
      flash[:failure] = 'It appears that you already have a password...'
      redirect_to password_test_path
    
    elsif @user
      @user.create_activation_digest
      UserMailer.log_in(@user).deliver_now
      flash[:success] = 'Welcome back! An email has been sent with a login link.'
      redirect_to root_url
    
    else
      @user = User.create(email: params[:session][:email].downcase)
      @user.create_activation_digest
      UserMailer.log_in(@user).deliver_now
      flash[:success] = 'Welcome! An email has been sent with a login link.'
      redirect_to root_url
    end
    
    # if @user && @user.authenticate(params[:session][:password])
    #   if @user.activated?
    #     log_in @user
    #     params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
    #     redirect_back_or dashboard_path
        
    #   else
    #     message  = "Account not activated. "
    #     message += "Check your email for the activation link."
    #     flash[:warning] = message
    #     redirect_to root_url
    #   end
      
    # else
    #   flash.now[:failure] = 'Invalid email/password combination'
    #   render 'new'
    # end
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
  
  # def password
  #     @user = User.find(27)
  #   # @user = User.find_by(email: params[:session][:email].downcase)
  # end
  
  # def password_create
  #   log_in @user
  #   flash[:success] = 'Welcome back!'
  #   redirect_to root_url
  # end
end