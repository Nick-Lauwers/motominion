# questionable

class VehiclesController < ApplicationController
  
  before_action :logged_in_user, except: [:show, :search, :autocomplete]
  before_action :get_vehicle,    only:   [:destroy, :show, :edit, :update, 
                                          :favorite, :sold]
  
  def new
    @vehicle  = current_user.vehicles.build
    @complete = "13%"
  end
  
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
  
  def edit
    
    if current_user.id == @vehicle.user.id
      @photos = @vehicle.photos
      @complete = "100%"
    
    else
      flash[:danger] = "Access denied"
      redirect_to_back_or_default
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
      redirect_to vehicles_path
    
    else
      flash[:danger] = "Please provide all information for this vehicle."
      render 'edit'
    end
  end
  
  def index
    @vehicles = current_user.vehicles
  end
  
  def show
    
    @conversation = Conversation.new
    
    @user      = @vehicle.user
    @tested    = Appointment.where("vehicle_id = ? AND buyer_id = ? AND 
                                    status = ? AND date <= ?", 
                                   @vehicle.id, 
                                   current_user.id,
                                   "accepted",
                                   Time.now).present? if current_user
                                   
    @photos    = @vehicle.photos
    
    @reviews   = @vehicle.reviews
    @hasReview = @reviews.find_by(reviewer_id: current_user.id) if current_user
    
    @questions = @vehicle.questions
    @question  = current_user.questions.build if logged_in?
    
    @reply     = current_user.replies.build   if logged_in?

    # gon.vehicle = @vehicle

    # @replies   = @question.replies
    # @reply     = @question.replies.build   if logged_in?
  end
  
  def search
    
    if params[:vehicle].present?
      
      coordinates = Geocoder.coordinates(params[:city])
      
      @vehicles   = Vehicle.search params[:vehicle],
                                  where: { location: { near: {
                                                            lat: coordinates[0], 
                                                            lon: coordinates[1]
                                                              }, 
                                                        within: "20mi" } },
                                  page: params[:page], 
                                  per_page: 10

    else
      @vehicles = Vehicle.near(params[:city], 20).paginate(page: params[:page], 
                                                          per_page: 10)
    end
    
    @hash = Gmaps4rails.build_markers(@vehicles) do |vehicle, marker|
      
      marker.lat vehicle.latitude
      marker.lng vehicle.longitude
      
      marker.picture({
        url: "/assets/map-marker-red.png",
        width:  32,
        height: 32
      })
      
      marker.json({ :id => vehicle.id })
    end
  end
  
  def favorite
    
    if current_user.favorite_vehicles.exists?(vehicle_id: @vehicle.id)
      flash[:failure] = "#{ @vehicle.listing_name } has already been added to 
                         your wishlist!"
    
    else
      current_user.favorites << @vehicle
      flash[:success] = "#{ @vehicle.listing_name } was added to your wishlist!"
    end
    
    redirect_to :back
  end
  
  def sold
    
    if @vehicle.sold_at.present?
      flash[:failure] = "#{ @vehicle.listing_name } has already been marked as 
                         sold."

    else
      @vehicle.update_attribute(:sold_at, Time.now)
      flash[:success] = "#{ @vehicle.listing_name } has been marked as sold!"
    end
    
    redirect_to :back
  end
  
  def autocomplete
    render json: Vehicle.search(params[:vehicle], autocomplete: false, limit: 10).map do |vehicle|
    { listing_name: vehicle.listing_name, city: vehicle.address.city, value: vehicle.id }
  end
  end
  
  private
  
    def vehicle_params
      params.require(:vehicle).permit(:monday_availability,
                                      :tuesday_availability,
                                      :wednesday_availability,
                                      :thursday_availability,
                                      :friday_availability, 
                                      :saturday_availability, 
                                      :sunday_availability, :vehicle_condition, 
                                      :body_style, :color, :transmission, 
                                      :fuel_type, :drivetrain, :vin, 
                                      :listing_name, :street_address, 
                                      :apartment, :city, :state, :year, :price, 
                                      :mileage, :seating_capacity, :summary, 
                                      :sellers_notes, :is_leather_seats, 
                                      :is_sunroof, :is_navigation_system, 
                                      :is_dvd_entertainment_system, 
                                      :is_bluetooth, :is_backup_camera, 
                                      :is_remote_start, :is_tow_package, 
                                      :is_autonomy)
    end
    
    # Before filters
    
    # Identifies vehicle id.
    def get_vehicle
      @vehicle = Vehicle.find(params[:id])
    end
end

# add wrong user tests

# http://stackoverflow.com/questions/40260125/implement-add-to-favorites
# http://stackoverflow.com/questions/5831900/wishlist-relationships-in-rails
# http://stackoverflow.com/questions/13240109/implement-add-to-favorites-in-rails-3-4