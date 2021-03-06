# questionable

class VehiclesController < ApplicationController
  
  require 'will_paginate/array'
  
  before_action :logged_in_user,     except: [:show, :search, :autocomplete, 
                                              :feed, :synchronize_vehicles]
                                
  before_action :profile_pic_upload, only:   [:post]
  before_action :get_vehicle,        only:   [:destroy, :show, :update, :basics,
                                              :details, :upgrades, :photos, 
                                              :about_you, :consumer_activity,
                                              :post, :favorite, :unfavorite,
                                              :sold, :undo_sold, :bump,
                                              :telephone_call]
  before_action :private_buyer,      only:   [:favorite, :unfavorite]
  
  def upload
    SynchronizationWorker.perform_async
    flash[:notice] = "Vehicles getting added to db"
    redirect_to root_url
  end
  
  def new
    @vehicle = current_user.vehicles.build
    @vehicle.availabilities.build
  end
  
  def create
    
    @vehicle = current_user.vehicles.build(vehicle_params)
    update_score
    
    if @vehicle.save
      flash[:success] = "Basics saved; Complete all remaining details, then 
                         select 'Post Motorcycle'."
      redirect_to details_vehicle_path(@vehicle)
    
    else
      render 'new'
    end
  end

  def update
    
    if @vehicle.update(vehicle_params)
      update_score
      flash[:success] = "Updates saved."
    
    else
      Rails.logger.info(@vehicle.errors.messages.inspect)
      flash[:danger] = "Update failed."
    end
    
    redirect_to :back
  end
  
  def index
    
    @vehicles = current_user.vehicles

    respond_to do |format|
      format.html
      format.csv 
    end
  end
  
  def show
    
    if @vehicle.dealership.present?
      @google_reviews = @vehicle.dealership.google_reviews
    end
    
    if current_user
      VehicleView.create(user: current_user, vehicle: @vehicle)
    elsif request.remote_ip != nil
      VehicleView.create(ip_address: request.remote_ip, vehicle: @vehicle)
    else
      VehicleView.create(vehicle: @vehicle)
    end
    
    if current_user 
      
      if Impression.where("user_id = ? AND vehicle_id = ?",
                          current_user.id, @vehicle.id).exists?
        Impression.where("user_id = ? AND vehicle_id = ?",
                         current_user.id, @vehicle.id).
                   first.
                   increment!(:count)
      
      else
        
        if @vehicle.dealership.present? 
          Impression.create(impression_type: "vehicle",
                            count:           1,
                            user:            current_user,
                            vehicle:         @vehicle,
                            dealership:      @vehicle.dealership)
        
        else
          Impression.create(impression_type: "vehicle",
                            count:           1,
                            user:            current_user,
                            vehicle:         @vehicle)
        end
      end
      
    elsif request.remote_ip != nil
    
      if Impression.where("ip_address = ? AND vehicle_id = ?",
                          request.remote_ip, @vehicle.id).exists?
        Impression.where("ip_address = ? AND vehicle_id = ?",
                         request.remote_ip, @vehicle.id).
                  first.
                  increment!(:count)
    
      else
        
        if @vehicle.dealership.present?
          Impression.create(impression_type: "vehicle",
                            count:           1,
                            ip_address:      request.remote_ip,
                            vehicle:         @vehicle,
                            dealership:      @vehicle.dealership)
        
        else
          Impression.create(impression_type: "vehicle",
                            count:           1,
                            ip_address:      request.remote_ip,
                            vehicle:         @vehicle)
        end
      end
                       
    else
      
      if @vehicle.dealership.present?
        Impression.create(impression_type: "vehicle",
                          count:           1,
                          vehicle:         @vehicle,
                          dealership:      @vehicle.dealership)
      
      else
        Impression.create(impression_type: "vehicle",
                          count:           1,
                          vehicle:         @vehicle)
      end
    end
    
    @tested    = Appointment.where("vehicle_id = ? AND buyer_id = ? AND 
                                    status = ? AND date <= ?", 
                                   @vehicle.id, 
                                   current_user.id,
                                   "accepted",
                                   Time.now).present? if current_user
    
    @conversation     = Conversation.new
    @appointment      = Appointment.new
    @vehicle_inquiry  = VehicleInquiry.new
    @user             = @vehicle.user                               
    @photos           = @vehicle.photos
    @reviews          = @vehicle.reviews
    @hasReview        = @reviews.find_by(reviewer_id: current_user.id) if current_user
    @availabilities   = @vehicle.availabilities
    @related_vehicles = Vehicle.
                          where(vehicle_make: @vehicle.vehicle_make).
                          near("#{@vehicle.city}, #{@vehicle.state}", 150).
                          first(3)
    @related_vehicles_mobile = Vehicle.
                                 where(vehicle_make: @vehicle.vehicle_make).
                                 near("#{@vehicle.city}, #{@vehicle.state}", 150).
                                 first(4)
  end
  
  def search

    @filterrific = initialize_filterrific(
      
      Vehicle,
      params[:filterrific],
      
      select_options: {
        sorted_by:             Vehicle.options_for_sorted_by,
      },
      
      persistence_id: false,
      default_filter_params: {},
      
      available_filters: [
        :with_vehicle_make_id, 
        :with_vehicle_model_id,
        :with_zip_code,
        :with_distance,
        :near_city,
        :with_cafe_racer,
        :with_cruiser,
        :with_dirt_bike_dual_sport,
        :with_moped_mini,
        :with_sportbike,
        :with_standard,
        :with_touring,
        :with_trike,
        :with_condition,
        :with_dealer,
        :with_year_gte,
        :with_actual_price_lte,
        :with_mileage_numeric_lte,
        :with_engine_size_gte,
        :with_body_style,
        :with_color,
        :with_engine_type,
        :with_fuel_type,
        :with_cruise_control,
        :with_am_fm,
        :with_cb_radio,
        :with_navigation_system,
        :with_heated_seats,
        :with_heated_hand_grips,
        :with_alarm_system,
        :with_saddlebags,
        :with_trunk,
        :with_tow_hitch,
        :with_cycle_cover,
        :with_manufacturer
      ],
    ) or return
    
    @vehicles = @filterrific.
                  find.
                  where(sold_at: nil).
                  includes(:listing_score).
                  order("listing_scores.overall_score DESC").
                  paginate(page: params[:page], per_page: 10)
    
    @geojson = Array.new;

    @vehicles.each do |vehicle|
      @geojson << {
        type: 'Feature',
        id: vehicle.id,
        geometry: {
          type: 'Point',
          coordinates: [ vehicle.longitude, vehicle.latitude ]
        },
        properties: {
          "id":    vehicle.id,
          "title": vehicle.listing_name
        }
      }
    end
    
    @vehicle = Vehicle.new
    
    if current_user && current_user.personalized_search.present?
      @personalized_search = current_user.personalized_search
    else
      @personalized_search = PersonalizedSearch.new
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end
    
  def basics
  end
  
  def details
  end
  
  def photos
    @photos = @vehicle.photos
  end
  
  def about_you
  end
  
  def consumer_activity
    
    @orders = Purchase.
                where(seller_id: current_user.id).
                where.not(processed_at: nil)
    
    @test_drives = Appointment.
                     where("seller_id = ? AND date >= ?",
                     current_user.id,
                     Time.now)
  end
  
  def post
    @vehicle.update_attribute(:posted_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } posted!"
    redirect_to vehicles_path
  end
  
  def favorite
    
    if !current_user.favorite_vehicles.exists?(vehicle: @vehicle)
      current_user.favorites << @vehicle 
    end
      
    if params[:is_loved] == "true"
      
      current_user.
      favorite_vehicles.
      where(vehicle: @vehicle).
      first.
      update_attributes(is_loved: true, is_liked: false, is_disliked: false)
    
      flash[:success] = "#{ @vehicle.listing_name } has been added to your 
                         shortlist!"
      
      redirect_to shortlist_user_path(current_user)
                         
    elsif params[:is_liked] == "true"
      
      current_user.
      favorite_vehicles.
      where(vehicle: @vehicle).
      first.
      update_attributes(is_loved: false, is_liked: true, is_disliked: false)
      
      flash[:success] = "#{ @vehicle.listing_name } has been added to your 
                         shortlist!"
      
      redirect_to shortlist_user_path(current_user)
                         
    else
      
      current_user.
      favorite_vehicles.
      where(vehicle: @vehicle).
      first.
      update_attributes(is_loved: false, is_liked: false, is_disliked: true)
      
      flash[:failure] = "#{ @vehicle.listing_name } will be removed from your
                         feed." 
                         
      redirect_to @vehicle
    end
  end
    
  def unfavorite
    
    FavoriteVehicle.
      where(vehicle: @vehicle).
      first.
      update_attributes(is_loved: false, is_liked: false)
    
    flash[:failure] = "#{ @vehicle.listing_name } will be removed from your
                       shortlist." 
      
    redirect_to :back
  end
  
  def sold
    @vehicle.update_attribute(:sold_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } has been marked as sold!"
    redirect_to :back
  end
  
  def undo_sold
    @vehicle.update_attribute(:sold_at, nil)
    flash[:success] = 
      "#{ @vehicle.listing_name } is now available for purchase!"
    redirect_to :back
  end
  
  def bump
    @vehicle.update_attribute(:bumped_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } has been bumped!"
    redirect_to :back
  end
  
  def autocomplete
    render json: Vehicle.search(params[:vehicle], autocomplete: false, limit: 10).map do |vehicle|
      { listing_name: vehicle.listing_name, city: vehicle.address.city, value: vehicle.id }
    end
  end
  
  def telephone_call
    @vehicle.telephone_call.create(user: current_user)
  end
  
  def feed
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
  
  private
    
    # Gets filterrific
    def get_filterrific
      
      @filterrific = initialize_filterrific(
      
      Vehicle,
      params[:filterrific],
      
      select_options: {
        sorted_by:             Vehicle.options_for_sorted_by,
        with_vehicle_make_id:  VehicleMake.options_for_select,
        with_vehicle_model_id: VehicleModel.options_for_select
      },
      
      persistence_id: false,
      default_filter_params: {},
      
      available_filters: [
        :with_vehicle_make_id, 
        :with_vehicle_model_id,
        :with_zip_code
      ],
    ) or return
    end
    
    def vehicle_params
      params.require(:vehicle).permit(:user_id, :dealership_id, :listing_name,
                                      :vehicle_make_id, :vehicle_model_id, 
                                      :msrp, :actual_price, :year, :mileage, 
                                      :mileage_numeric, :body_style, :color,
                                      :engine_type, :fuel_type, :vin, 
                                      :engine_size, :description,
                                      :description_clean, :cruise_control, 
                                      :am_fm, :cb_radio, :navigation_system,
                                      :heated_seats, :heated_hand_grips, 
                                      :alarm_system, :saddlebags, :trunk,
                                      :tow_hitch, :cycle_cover, :street_address, 
                                      :apartment, :city, :state, :bumped_at, 
                                      :posted_at, :condition, :trim_details,
                                      :engine, :displacement, 
                                      :compression_ratio, :bore_stroke, :bore, 
                                      :stroke, :transmission, :primary_drive, 
                                      :final_drive, :fuel_system, 
                                      :fuel_capacity, :brakes, :front_brakes, 
                                      :rear_brakes, :suspension, 
                                      :front_suspension, :rear_suspension,
                                      :tires, :front_tire, :rear_tire,
                                      :dry_weight, :curb_weight, :rake_trail, 
                                      :rake, :trail, :wheelbase,
                                      :ground_clearance, :seat_height,
                                      :seat_height_laden, :seat_height_unladen,
                                      availabilities_attributes: [:id, :day, 
                                      :start_time, :end_time, :vehicle_id, 
                                      :_destroy], upgrades_attributes: [:id, 
                                      :title, :description, :duration, :price, 
                                      :_destroy])
    end
    
    # Updates score
    def update_score
      
      # Listing location is included and is an exact address.
      if @vehicle.latitude.present?
        location_score = 100
      else
        location_score = 0
      end
      
      # Features are properly noted.
      if @vehicle.cruise_control || @vehicle.am_fm || @vehicle.cb_radio || 
         @vehicle.navigation_system || @vehicle.heated_seats || 
         @vehicle.heated_hand_grips || @vehicle.alarm_system || 
         @vehicle.saddlebags || @vehicle.trunk || @vehicle.tow_hitch || 
         @vehicle.cycle_cover
        features_score = 100
        
      else
        features_score = 0
      end
      
      # Specifications are properly noted.
      spec_score = 0
      
      spec_score += 1 if @vehicle.color.present?
      spec_score += 1 if @vehicle.engine_type.present?
      spec_score += 1 if @vehicle.fuel_type.present?
      spec_score += 1 if @vehicle.engine_size.present?
      
      spec_score = 25 * spec_score
      
      # VIN has been properly noted.
      if @vehicle.vin.present?
        vin_score = 100
      else
        vin_score = 0
      end
      
      # Vehicle is listed by a certified dealer and dealership sends a direct
      # feed.
      if @vehicle.dealership.present? && 
         @vehicle.dealership.scraped_id.present?
        certified_dealer_score = 100
        direct_listing_score = 100
        
      elsif @vehicle.dealership.present?
        certified_dealer_score = 0
        direct_listing_score = 0
        
      else
        certified_dealer_score = 100
        direct_listing_score = 100
      end 
      
      # Seller accepts test drives, on-demand.
      test_drive_score = 100
      
      # Listing has many photos.
      if @vehicle.photos.count == 0
        photos_score = 0
      elsif @vehicle.photos.count.between?(1,3)
        photos_score = 33
      elsif @vehicle.photos.count.between?(4,7)
        photos_score = 67
      else
        photos_score = 100
      end
      
      # Seller has several positive reviews.
      
      # Listing was recently posted or bumped.
      if @vehicle.bumped_at >= 1.day.ago
        recently_posted_score = 100
      elsif @vehicle.bumped_at >= 3.days.ago
        recently_posted_score = 67
      else
        recently_posted_score = 33
      end
      
      # Seller has many high-quality listings.
      many_listings_score = 100
      
      # Calculate overall score.
      overall_score = ( location_score + features_score + spec_score + 
                        vin_score + certified_dealer_score +
                        direct_listing_score + test_drive_score + 
                        ( 3 * photos_score ) +
                        ( 2 * recently_posted_score ) + 
                        many_listings_score ) / 13
      
      if @vehicle.listing_score.present?
        @vehicle.listing_score.update_attributes(
          location_score:         location_score,
          features_score:         features_score,
          spec_score:             spec_score,
          vin_score:              vin_score,
          certified_dealer_score: certified_dealer_score,
          direct_listing_score:   direct_listing_score,
          test_drive_score:       test_drive_score,
          photos_score:           photos_score,
          recently_posted_score:  recently_posted_score,
          many_listings_score:    many_listings_score,
          overall_score:          overall_score
        )
      
      else                             
        @vehicle.build_listing_score(
          location_score:         location_score, 
          features_score:         features_score,
          spec_score:             spec_score, 
          vin_score:              vin_score, 
          certified_dealer_score: certified_dealer_score,
          direct_listing_score:   direct_listing_score,
          test_drive_score:       test_drive_score, 
          photos_score:           photos_score,
          recently_posted_score:  recently_posted_score,
          many_listings_score:    many_listings_score, 
          overall_score:          overall_score
        )
      end
    end
  
    # Before filters
    
    # Identifies vehicle id.
    def get_vehicle
      @vehicle = Vehicle.find(params[:id])
    end
end