# completed
# ensure that before actions are correct for payment and add_card

class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :add_card]
  before_action :correct_user,   only: [:edit, :update, :profile_pic]
  
  def new
    @user  = User.new
    @token = params[:invitation_token]
  end
  
  def create
    
    @user  = User.new(user_params)
    @token = params[:invitation_token]
    
    if @user.save
      
      # Determine if there is a way to add token after account activation.
      if @token != nil
        org = Invitation.find_by_token(@token).club
        @user.clubs.push(org)
      end
      
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
  
  def payment
  end
  
  def payout
    if !current_user.merchant_id.blank?
      account     = Stripe::Account.retrieve(current_user.merchant_id)
      @login_link = account.login_links.create()
    end
  end
  
  def add_card
    
    if current_user.stripe_id.blank?
      
      customer = Stripe::Customer.create(
        email: current_user.email
      )
      current_user.stripe_id = customer.id
      
      current_user.save
      customer.sources.create(source: params[:stripeToken])
      
    else
      
      customer        = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.source = params[:stripeToken]
      
      customer.save
    end
    
    flash[:notice] = "Your card is saved."
    redirect_to payment_method_path
    
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to payment_method_path
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