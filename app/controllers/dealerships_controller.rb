class DealershipsController < ApplicationController
  
  before_action :get_dealership, only: [:edit, :update, :show, :authentication, 
                                        :basics, :about, :contact, :hours, 
                                        :address, :logo, :photo, :vehicles, 
                                        :reviews, :insights]
  
  def new
    @dealership = Dealership.new
  end

  def create
    
    @dealership = Dealership.new(dealership_params)
    
    if @dealership.save
      @dealership.send_activation_email
      redirect_to authentication_dealership_path(@dealership)
    
    else
      flash[:failure] = "Please ensure that your email is valid and that your 
                         company name is no more than 50 characters."
      redirect_to new_dealership_path
    end
  end
  
  def edit
  end
  
  def update
    
    if @dealership.update(dealership_params)
      
      if params[:redirect_location].present?
        redirect_to params[:redirect_location]
      else
        redirect_to new_user_path(dealership_id:    @dealership.id,
                                  dealership_admin: true)
      end
      
    else
      flash[:failure]  = "Update failed."
      redirect_to :back
    end
  end
  
  def show
  end

  def authentication
  end

  def basics
  end
  
  def about
  end
  
  def contact
  end
  
  def hours
    @dealership.business_hours.build
  end
  
  def address
  end
  
  def logo
  end
  
  def photo
  end
  
  def insights
    @vehicle_views = Impression.where(dealership: @dealership)
  end
  
  def vehicles
    @vehicles = @dealership.
                  vehicles.
                  # where(sold_at: nil).
                  # where.not(posted_at: nil).
                  paginate(page: params[:page], per_page: 15)
  end
  
  def reviews
    @google_reviews = @dealership.google_reviews
  end
  
  private
  
    def dealership_params
      params.require(:dealership).permit(:name, :email, :description, :website,
                                         :sales_phone, :service_phone, 
                                         :street_address, :building, :city, 
                                         :state, :logo, :photo, 
                                         :google_place_id,
                                         business_hours_attributes: [:id, :day, 
                                         :open_time, :close_time, :is_closed,
                                         :dealership_id])
    end
    
    # Before filters
    
    # Identifies dealership id.
    def get_dealership
      @dealership = Dealership.find(params[:id])
    end
end
