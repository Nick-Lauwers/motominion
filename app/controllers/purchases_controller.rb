class PurchasesController < ApplicationController
  
  before_action :logged_in_user
  before_action :profile_pic_upload
  before_action :get_purchase, except: [:new, :create, :purchases_made, 
                                        :orders_received]
  
  def new
    
    @vehicle  = Vehicle.find(params[:vehicle_id])
    
    if Purchase.where('vehicle_id = ? AND buyer_id = ?', @vehicle.id, current_user.id).exists?
      redirect_to basics_purchase_path(Purchase.where('vehicle_id = ? AND buyer_id = ?', @vehicle.id, current_user.id).first)
    else
      @purchase = current_user.purchases_made.build
    end
  end

  def create
    
    @purchase = current_user.purchases_made.create!(purchase_params)
    
    if @purchase.save
      flash[:success] = "Basics saved."
      redirect_to details_purchase_path(@purchase)
    
    else
      # Produce an error on first save, then correct and save again; see what happens
      render 'new'
    end
  end
  
  def update
    
    if @purchase.update(purchase_params)
      flash[:success] = "Updates saved."
    else
      flash[:danger] = "Update failed."
    end
    
    redirect_to :back
  end
  
  def show
    
    @purchases = Purchase.where(buyer_id: current_user.id)
    
    @test_drives = Appointment.where("buyer_id = ? AND date >= ?", 
                                     current_user.id, 
                                     Time.now)
  end
  
  # def index
    
  #   @purchases = Purchase.all
    
  #   @test_drives = Appointment.where("buyer_id = ? AND date >= ?", 
  #                                   current_user.id, 
  #                                   Time.now)
  # end
  
  def purchases_made
    
    @purchases = Purchase.where(buyer_id: current_user.id)
    
    @test_drives = Appointment.where("buyer_id = ? AND date >= ?", 
                                     current_user.id, 
                                     Time.now)
  end
  
  def orders_received
    @orders = Purchase.
                where(seller_id: current_user.id).
                where.not(processed_at: nil)
  end

  def basics
  end

  def upgrades
  end

  def billing
  end

  def employment
  end

  def financial
  end
  
  def submit
    @purchase.update_attribute(:processed_at, Time.now)
    flash[:success] = "Purchase currently processing."
    redirect_to purchases_made_path
  end
  
  private
  
    def purchase_params
      params.require(:purchase).permit(:vehicle_id, :seller_id, :first_name, 
                                       :last_name, :email, :phone_number, 
                                       :billing_first_name, :billing_last_name,
                                       :billing_street_address, 
                                       :billing_apartment, :billing_city, 
                                       :billing_state, :education, :employment,
                                       :employer_name, :employer_phone,
                                       :current_title, :residence_type, 
                                       :annual_income, :time_at_job, 
                                       :monthly_payment, :time_at_address,
                                       :is_extended_service_contract, 
                                       :is_wheel_tire_care, :is_ding_dent_care,
                                       :is_key_replacement, 
                                       :is_resistall_protection, :date_of_birth,
                                       :processed_at, :upgrade_ids => [])
    end
    
    # Before filters
    
    # Identifies purchase id.
    def get_purchase
      @purchase = Purchase.find(params[:id])
    end
end
