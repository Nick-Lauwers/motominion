class VehiclesController < ApplicationController
  before_action :logged_in_user, except: [:show]
  before_action :set_vehicle,    only:   [:destroy, :show, :edit, :update]
  
  def create
    @vehicle = current_user.vehicles.build(vehicle_params)
    if @vehicle.save
      if params[:images]
        params[:images].each do |image|
          @vehicle.photos.create(image: image)
        end
      end
      @photos = @vehicle.photos
      flash[:success] = "Vehicle saved"
      redirect_to vehicles_path
    else
      render 'new'
    end
  end
  
  def destroy
    @vehicle.destroy
    flash[:success] = "Vehicle deleted"
    redirect_to vehicles_path
  end
  
  def index
    @vehicles = current_user.vehicles
  end
  
  def show
    @user      = @vehicle.user
    @photos    = @vehicle.photos
    @reviews   = @vehicle.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
    @booked    = Appointment.where("vehicle_id = ? AND user_id = ?", @vehicle.id, current_user.id).present? if current_user
    
    @comments  = @vehicle.comments
    @comment = current_user.comments.build if logged_in?
    
    @comments.each { 
      |comment|
        @replies = comment.replies
    }
    @reply   = current_user.replies.build  if logged_in?
  end
  
  def new
    @vehicle = current_user.vehicles.build
  end
  
  def edit
    if current_user.id == @vehicle.user.id
      @photos = @vehicle.photos
    else
      flash[:danger] = "Access denied"
      redirect_to root_path
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      if params[:images]
        params[:images].each do |image|
          @vehicle.photos.create(image: image)
        end
      end
      flash[:success] = "Vehicle updated"
      redirect_to edit_vehicle_path(@vehicle)
    else
      flash[:danger] = "Please provide all information for this vehicle."
      render 'edit'
    end
  end
  
  private
  
    def vehicle_params
      params.require(:vehicle).permit(:vehicle_condition, :body_style, :color, 
                                      :transmission, :fuel_type, :drivetrain, 
                                      :vin, :listing_name, :address, :year, 
                                      :price, :mileage, :seating_capacity, 
                                      :summary, :sellers_notes, 
                                      :is_leather_seats, :is_sunroof, 
                                      :is_navigation_system, 
                                      :is_dvd_entertainment_system, 
                                      :is_bluetooth, :is_backup_camera, 
                                      :is_remote_start, :is_tow_package, 
                                      :is_autonomy)
    end
    
    # Before filters
    
    # Identifies vehicle id.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end
end
