# completed

class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :profile_pic]
  
  def new
    @user = User.new
  end
  
  def create
    
    @user = User.new(user_params)
    
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_back_or edit_user_path(@user)
      
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    @conversation = Conversation.new
    @reviews      = @user.received_reviews
  end
  
  def profile_pic
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation, :is_subscribed, 
                                   :phone_number, :residence, :school, :work, 
                                   :description, :avatar)
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

# add delete and associated tests