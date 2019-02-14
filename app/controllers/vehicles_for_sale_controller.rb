class VehiclesForSaleController < ApplicationController
  
  before_action :get_personalized_search
  
  def san_francisco
    @region = "San Francisco, CA"
    map_parameters
  end
  
  def oakland
    @region = "Oakland, CA"
    map_parameters
  end
  
  def san_jose
    @region = "San Jose, CA"
    map_parameters
  end
  
  def los_angeles
    @region = "Los Angeles, CA"
    map_parameters
  end
  
  def long_beach
    @region = "Long Beach, CA"
    map_parameters
  end

  def san_diego
    @region = "San Diego, CA"
    map_parameters
  end
  
  def cafe_racers
    @body_style = "Cafe Racer"
    map_parameters
  end
  
  def cruisers
    @body_style = "Cruiser"
    map_parameters
  end
  
  def dirt_bikes
    @body_style = "Dirt Bike / Dual-Sport"
    map_parameters
  end
  
  def dual_sports
    @body_style = "Dirt Bike / Dual-Sport"
    map_parameters
  end
  
  def minis_pockets
    @body_style = "Mini / Pocket"
    map_parameters
  end
  
  def mopeds
    @body_style = "Moped"
    map_parameters
  end
  
  def sportbikes
    @body_style = "Sportbike"
    map_parameters
  end
  
  def standards
    @body_style = "Standard"
    map_parameters
  end
  
  def tourings
    @body_style = "Touring"
    map_parameters
  end
  
  def trikes
    @body_style = "Trike"
    map_parameters
  end
  
  def aprilia
  end
  
  def bmw
  end
  
  def can_am
  end
  
  def ducati
  end
  
  def harley_davidson
  end
  
  def honda
  end
  
  def indian
  end
  
  def kawasaki
  end
  
  def ktm
  end
  
  def kymco
  end
  
  def suzuki
  end
  
  def triumph
  end
  
  def vespa
  end
  
  def victory
  end
  
  def yamaha
  end  
  
  private
    
    # Identifies personalized search id.
    def get_personalized_search
      if current_user && current_user.personalized_search.present?
        @personalized_search = current_user.personalized_search
      else
        @personalized_search = PersonalizedSearch.new
      end
    end
    
    # Prepare map parameters
    def map_parameters
      
      @vehicles = Vehicle.
                    near(@region).
                    joins(:vehicle_model).
                    where('vehicle_models.vehicle_type = ?', @body_style).
                    where(sold_at: nil).
                    includes(:listing_score).
                    order("listing_scores.overall_score DESC").
                          # ,
                          # "year DESC",
                          # "listing_name ASC").
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
            # "image": vehicle.photos[0].image.url(),
            "title": vehicle.listing_name
          }
        }
      end
      
      respond_to do |format|
        format.html
        format.json { render json: @geojson }
      end
    end
end