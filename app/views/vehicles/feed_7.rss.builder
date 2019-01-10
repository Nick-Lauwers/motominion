xml.instruct! :xml, :version => "1.0"
xml.listings do
  xml.title "Vehicles Feed"
  xml.link :rel => "self", :href => "https://www.motominion.com"

  Vehicle.
    where(id: 7000..7999).
    where.not(dealership_id: nil).
    joins(:photos).
    group('vehicles.id').
    having('count(photos) > 2').
    each do |vehicle|
     
    xml.listing do
    
      xml.vehicle_id vehicle.id
      
      if vehicle.listing_name.present?
        xml.title vehicle.listing_name
      else
        xml.title "Title is unavailable."
      end
      
      if vehicle.description_clean.present?
        xml.description vehicle.description_clean.truncate(100)
      else
        xml.description "Description is unavailable."
      end
      
      xml.url asset_url( url_for(vehicle) )
      
      if vehicle.vehicle_make.present?
        xml.make vehicle.vehicle_make.name
      elsif vehicle.vehicle_make_name.present?
        xml.make vehicle.vehicle_make_name
      else
        xml.make "UNKNOWN"
      end
      
      if vehicle.vehicle_model.present?
        xml.model vehicle.vehicle_model.name
      elsif vehicle.vehicle_model_name.present?
        xml.model vehicle.vehicle_model_name
      else
        xml.model "UNKOWN"
      end
      
      if vehicle.year.present?
        xml.year vehicle.year
      else
        xml.year 0000
      end
      
      xml.mileage do

        if vehicle.mileage_numeric.present?
          xml.value vehicle.mileage_numeric
        else
          xml.value 0
        end
        
        xml.unit 'MI'
      end
      
      xml.drivetrain "Other"
      
      if vehicle.vin.present?
        xml.vin vehicle.vin
      else
        xml.vin "aaaaaUNKOWNaaaaaa"
      end
      
      xml.body_style "OTHER"
      
      if vehicle.fuel_type == "Electric"
        xml.fuel_type "ELECTRIC"
      else
        xml.fuel_type "GASOLINE"
      end
      
      xml.transmission "AUTOMATIC"
      
      xml.condition "Other"
      
      if vehicle.actual_price.present?
        xml.price vehicle.actual_price.to_s + " USD"
      elsif vehicle.msrp.present?
        xml.price vehicle.msrp.to_s + " USD"
      else
        xml.price "0 USD"
      end
      
      xml.address :format => "simple" do
        xml.component(vehicle.street_address, :name => "addr1") 
        xml.component(vehicle.city,           :name => "city") 
        xml.component(vehicle.state,          :name => "region") 
        xml.component("US",                   :name => "country") 
      end
      
      xml.latitude vehicle.latitude
      
      xml.longitude vehicle.longitude
      
      if vehicle.color.present?
        xml.exterior_color vehicle.color
      else
        xml.exterior_color "Unknown"
      end

      xml.sale_price   nil
      
      if vehicle.last_found_at >= 2.days.ago
        xml.availability "AVAILABLE"
      else
         xml.availability "NOT_AVAILABLE"
      end

      if vehicle.condition == "New"
        xml.state_of_vehicle "NEW"
      else
        xml.state_of_vehicle "USED"
      end
      
      xml.dealer_id    vehicle.dealership.id
      xml.dealer_name  vehicle.dealership.dealership_name
      xml.dealer_phone vehicle.dealership.sales_phone
      
      if vehicle.vehicle_model.present?
        xml.custom_label_0 vehicle.vehicle_model.vehicle_type
      elsif vehicle.body_style.present?
        xml.custom_label_0 vehicle.body_style
      else
        xml.custom_label_0 "Other"
      end
      
      xml.image do
        xml.url "https:" + URI.unescape( vehicle.photos[0].image.url() ).to_s
        xml.tag nil
      end
      
      xml.image do
        xml.url "https:" + URI.unescape( vehicle.photos[2].image.url() ).to_s
        xml.tag nil
      end
      
      if vehicle.photos[3].present?
        xml.image do
          xml.url "https:" + URI.unescape( vehicle.photos[3].image.url() ).to_s
          xml.tag nil
        end
      end
    end
  end
end