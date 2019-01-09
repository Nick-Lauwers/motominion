# completed
# ensure that before actions are correct for payment and add_card

class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :add_card]
  before_action :correct_user,   only: [:edit, :update, :profile_pic, 
                                        :profile_pic_dealer, :dealer_details]
  before_action :private_buyer,  only: [:shortlist]
  
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
    
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password, 
                                   :password_confirmation, :is_subscribed, 
                                   :phone_number, :residence, :school, :work, 
                                   :description, :avatar, :dealership_id, 
                                   :dealership_admin, :activated, :activated_at))
    # @token = params[:invitation_token]
    
    if @user.save
      
      initiated_conversations_params = 
        user_params[:initiated_conversations_attributes]['0'].
          permit(:id, :recipient_id, :is_sender_anonymous, :latest_message_read, 
                 :sender_archived, :recipient_archived)
      
      vehicle_inquiries_params = 
        user_params[:initiated_conversations_attributes]['0'][:vehicle_inquiries_attributes]['0'].
          permit(:id, :price, :special_offers, :availability, :condition,
                 :vehicle_history, :test_drives, :user_id, :vehicle_id, :email, 
                 :first_name, :last_name)
      
      @conversation = @user.
                        initiated_conversations.
                        create!(initiated_conversations_params)
                        
      @vehicle_inquiry = @conversation.
                           vehicle_inquiries.
                           create!(vehicle_inquiries_params)                  
      
      @vehicle_inquiry.update_attributes!(user_id:    @user.id, 
                                          email:      @user.email, 
                                          first_name: @user.first_name, 
                                          last_name:  @user.last_name)
      
      inquiry_booleans = [ @vehicle_inquiry.price, 
                           @vehicle_inquiry.special_offers,
                           @vehicle_inquiry.availability,
                           @vehicle_inquiry.condition,
                           @vehicle_inquiry.vehicle_history,
                           @vehicle_inquiry.test_drives ];
                           
      inquiry_strings = [ "pricing", "special offers", "availability",
                          "condition", "vehicle history", 
                          "scheduling a test drive" ];
                          
      string  = "";
      
      for i in 0..inquiry_booleans.count
        if inquiry_booleans[i] == true
          string = string + inquiry_strings[i] + "; "
        end
      end

      message = @conversation.messages.create!(
                  user:    @user, 
                  content: "Hi, " + 
                           @conversation.recipient.first_name + 
                           ". I recently noticed your motorcycle, " +
                           @vehicle_inquiry.vehicle.listing_name + 
                           ", and have questions about: " +
                           string
                )
      
      @conversation.update_attributes(next_contributor_id: @conversation.recipient.id, 
                                      latest_message_read: false)
      
      MessageMailer.message_received(message).deliver_now
      MessageMailer.message_received_admin(message).deliver_now
                                   
      log_in @user
      flash[:success] = "Message sent!"
      
    else
      flash[:failure] = "This email address has already been taken; If the 
                        address belongs to you, please
                        #{view_context.link_to("log in", login_path)}
                        to continue."
    end
    
    redirect_to :back
    
    #   # Determine if there is a way to add token after account activation.
    #   if @token != nil
    #     org = Invitation.find_by_token(@token).club
    #     @user.clubs.push(org)
    #   end
      
    #   if @user.dealership_id.present?
    #     log_in @user
    #     redirect_to dealer_details_user_path(@user)
        
    #   # if @user.dealership_admin
    #   #   log_in @user
    #   #   redirect_to new_dealership_dealer_invitation_path(@user.dealership_id)
    #   # elsif @user.dealership_id.present?
    #   #   log_in @user
    #   #   redirect_to dealership_path(@user.dealership_id)
      
    #   else
    #     @user.send_activation_email
    #     flash[:info] = "Please check your email to activate your account."
    #     redirect_to root_url
    #   end
      
    # else
    #   # if params[:dealership_admin].present?
    #   #   render 'new_dealer_admin'
    #   # elsif params[:dealership_id].present?
    #   #   render 'new_dealer'
    #   # else
    #     render 'new'
    #   # end
  end
  
  def edit
  end
  
  def update
    
    if @user.update_attributes(user_params)
      
      if params[:redirect_location].present?
        redirect_to params[:redirect_location]
      
      else
        flash[:success] = "Profile updated"
        redirect_back_or edit_user_path(@user)
      end
      
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
  
  def profile_pic_dealer
  end
  
  def dealer_details
  end
  
  def password
    @user = User.find(params[:id])
  end

  def shortlist
    
    @purchases = Purchase.where(buyer_id: current_user.id)
    
    @test_drives = Appointment.where("buyer_id = ? AND date >= ?", 
                                     current_user.id, 
                                     Time.now)
    
    @loved_items = current_user.favorite_vehicles.where(is_loved: true)
    
    @liked_items = current_user.favorite_vehicles.where(is_liked: true)
    
    @vehicles = current_user.
                  favorites.
                  joins(:favorite_vehicles).
                  where(favorite_vehicles: {is_loved: true}).
                  or(favorite_vehicles: {is_liked: true}).
                  or(favorite_vehicles: {is_test_drive: true}).
                  or(favorite_vehicles: {is_purchase: true})
                  
    shortlist_items = current_user.
                        favorites.
                        joins(:favorite_vehicles).
                        where(favorite_vehicles: {is_loved: true}).
                        or(favorite_vehicles: {is_liked: true})
    
    test_drive_items = Appointment.where("buyer_id = ? AND date >= ?", 
                                         current_user.id, 
                                         Time.now)
    
    purchase_items = Purchase.where(buyer_id: current_user.id)

    @geojson = Array.new;

    shortlist_items.each do |vehicle|
      
      @geojson << {
        type: 'Feature',
        id: "shortlist-item-" + vehicle.id.to_s,
        geometry: {
          type: 'Point',
          coordinates: [ vehicle.longitude, vehicle.latitude ]
        },
        properties: {
          "id":    "shortlist-item-" + vehicle.id.to_s,
          # "image": vehicle.photos[0].image.url(),
          "title": vehicle.listing_name
        }
      }
    end
    
    test_drive_items.each do |appointment|
      
      @geojson << {
        type: 'Feature',
        id: "test-drive-item-" + appointment.id.to_s,
        geometry: {
          type: 'Point',
          coordinates: [ appointment.vehicle.longitude, 
                         appointment.vehicle.latitude ]
        },
        properties: {
          "id":    "test-drive-item-" + appointment.id.to_s,
          # "image": vehicle.photos[0].image.url(),
          "title": appointment.vehicle.listing_name
        }
      }
    end
    
    purchase_items.each do |purchase|
      
      @geojson << {
        type: 'Feature',
        id: "purchase-item-" + purchase.id.to_s,
        geometry: {
          type: 'Point',
          coordinates: [ purchase.vehicle.longitude, purchase.vehicle.latitude ]
        },
        properties: {
          "id":    "purchase-item-" + purchase.id.to_s,
          # "image": vehicle.photos[0].image.url(),
          "title": purchase.vehicle.listing_name
        }
      }
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
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
  
  def password
  end
      
  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, 
                                   :password_confirmation, :is_subscribed, 
                                   :phone_number, :residence, :school, :work, 
                                   :description, :avatar, :dealership_id, 
                                   :dealership_admin, :activated, :activated_at,
                                   initiated_conversations_attributes: 
                                   [:id, :recipient_id, :is_sender_anonymous, 
                                   :latest_message_read, :sender_archived, 
                                   :recipient_archived,
                                   vehicle_inquiries_attributes: [:id, :price, 
                                   :special_offers, :availability, :condition,
                                   :vehicle_history, :test_drives, :user_id,
                                   :vehicle_id, :email, :first_name, 
                                   :last_name]])
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

# add delete and associated tests


# User.create(first_name: 'Matt', last_name: 'Graves', email: 'matt@munroemotors.com', password: '98391004', password_confirmation: '98391004', avatar_url: 'https://randomuser.me/api/portraits/men/31.jpg', dealership_id: 3)
# User.create(first_name: 'Neal', last_name: 'Reyes', email: 'neal@scuderiawest.com', password: '98391006', password_confirmation: '98391006', avatar_url: 'https://randomuser.me/api/portraits/men/94.jpg', dealership_id: 4)
