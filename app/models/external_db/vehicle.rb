module ExternalDb
  class Vehicle < Record
    
    self.table_name = 'vehicle'
    belongs_to :source
    has_many :photos

    def sync_to_vehicle
      if ( vehicle_type_id == 3 || vehicle_type_id == 4 )
        ::Vehicle.where(scraped_id: id).first_or_initialize.tap do |v|
          
          v.dealership = ::Dealership.where(scraped_id: source_id).first
          v.vehicle_make_name = make
          v.vehicle_model_name = model
          v.listing_name = "#{year} #{make} #{model}"
          v.actual_price = price
          v.engine_type = engine
          v.created_at = created
          v.posted_at = created
          v.bumped_at = created
          v.last_found_at = last_found

          %i[msrp year mileage mileage_numeric body_style vin description 
          description_clean ad_url].each do |f|
            v.send("#{f}=", send(f))
          end
          
          normalized_vehicle_make_name  = make.downcase.gsub(/[^0-9a-z]/, '')
          normalized_vehicle_model_name = model.downcase.gsub(/[^0-9a-z]/, '')
          
          VehicleMake.all.each do |vehicle_make|
            if vehicle_make.name.downcase.gsub(/[^0-9a-z]/, '').in?(normalized_vehicle_make_name)
              
              v.vehicle_make = vehicle_make
              
              VehicleModel.all.each do |vehicle_model|
                if vehicle_model.name.downcase.gsub(/[^0-9a-z]/, '').in?normalized_vehicle_model_name
                  v.vehicle_model = vehicle_model
                end
              end
            end
          end
          
          v.save
        end
      end
    end
  end
end

# Vehicle.where(dealership_id: 3).each do |vehicle|
#   vehicle.latitude  = 50.0413454
#   vehicle.longitude = -113.59097220000001
#   vehicle.save
# end

# http://www.bryceholcomb.com/2015/02/10/mapbox-and-rails/