# completed
# ensure that before actions are correct for payment and add_card

class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :add_card]
  before_action :correct_user,   only: [:edit, :update, :profile_pic]
  
  def new
    
    @user  = User.new
    
    if params[:dealership_admin] == 'true'
      render 'new_dealer_admin'
    elsif params[:dealership_id].present?
      render 'new_dealer'
    else
      render 'new'
    end
    
    # @token = params[:invitation_token]
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
      
      if @user.dealership_admin
        log_in @user
        redirect_to new_dealership_dealer_invitation_path(@user.dealership_id)
      elsif @user.dealership_id.present?
        log_in @user
        redirect_to dealership_path(@user.dealership_id)
      else
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      end
      
    else
      
      flash[:failure]  = "Please enter a valid email address and a password of at least six characters."
      redirect_to :back
      
      # if params[:dealership_admin].present?
      #   render 'new_dealer_admin'
      # elsif params[:dealership_id].present?
      #   render 'new_dealer'
      # else
      #   render 'new'
      # end
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
      params.require(:user).permit(:first_name, :last_name, :email, :password, 
                                   :password_confirmation, :is_subscribed, 
                                   :phone_number, :residence, :school, :work, 
                                   :description, :avatar, :dealership_id, 
                                   :dealership_admin, :activated, :activated_at)
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

# add delete and associated tests