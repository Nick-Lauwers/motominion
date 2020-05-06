class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    @user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && 
       @user.password_digest.present? && 
       @user.authenticate(params[:session][:password])
      log_in @user
      redirect_back_or dashboard_path
    
    elsif @user && @user.password_digest.present?
      redirect_to password_user_path(@user)
    
    elsif @user
    
      @user.create_activation_digest
      UserMailer.log_in(@user).deliver_now
      
      if @user.first_name.present?
        flash[:success] = "#{@user.first_name}, we've sent you an email with a 
                           login link. It may take a second or two to arrive. Go 
                           check!"
      else
        flash[:success] = "We've sent you an email with a login link. It may 
                           take a second or two to arrive. Go check!"
      end
      
      redirect_to root_url
    
    else
      
      @user = User.create(email: params[:session][:email].downcase)
      @user.create_activation_digest
      UserMailer.log_in(@user).deliver_now
      flash[:success] = "Welcome! We've sent you an email with a login link.
                         It may take a second or two to arrive."
      redirect_to root_url
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