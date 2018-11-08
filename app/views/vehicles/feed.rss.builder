#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Codingfish"
    xml.author "Achim Fischer"
    xml.description "Software-Development, Mobiles Devices, Photography"
    xml.link "https://www.codingfish.com"
    xml.language "en"
    
    Dealership.all.each do |dealership| 
      dealership.
        vehicles.
        joins(:photos).
        group('vehicles.id').
        having('count(photos) > 2').
        order("RANDOM()").
        limit(1).
        each do |vehicle|
        
        xml.item do
        
          xml.id                vehicle.id
          xml.url               asset_url( url_for(vehicle) )
          xml.mileage_unit      'MI'
          xml.image_tag_0       nil
          xml.image_tag_1       nil
          xml.image_tag_2       nil
          xml.transmission      "AUTOMATIC"
          xml.body_style        "OTHER"
          xml.drivetrain        "Other"
          xml.condition         "Other"
          xml.availability      "AVAILABLE"
          xml.address           "{addr1: '#{vehicle.street_address}', city: '#{vehicle.city}', region: '#{vehicle.state}', country: 'US' }"
          xml.sale_price        nil
          xml.dealer_id         vehicle.dealership.id
          xml.latitude          vehicle.latitude
          xml.longitude         vehicle.longitude
          xml.date_first_on_lot "2018-11-01"
          xml.dealer_name       vehicle.dealership.dealership_name
          xml.dealer_phone      vehicle.dealership.sales_phone
          
          if vehicle.listing_name.present?
            xml.title vehicle.listing_name
          else
            xml.title "Title is unavailable."
          end
          
          if vehicle.description_clean.present?
            xml.description vehicle.description_clean
          else
            xml.description "Description is unavailable."
          end
          
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
            xml.year 1990
          end
          
          xml.image_url_0 "https:" + URI.unescape( vehicle.photos[0].image.url() ).to_s
          xml.image_url_1 "https:" + URI.unescape( vehicle.photos[1].image.url() ).to_s
          xml.image_url_2 "https:" + URI.unescape( vehicle.photos[2].image.url() ).to_s
          
          if vehicle.mileage_numeric.present?
            xml.mileage_value vehicle.mileage_numeric
          else
            xml.mileage_value 0
          end
          
          if vehicle.fuel_type == "Electric"
            xml.fuel_type "ELECTRIC"
          else
            xml.fuel_type "GASOLINE"
          end
          
          if vehicle.vin.present?
            xml.vin vehicle.vin
          else
            xml.vin = "aaaaaUNKOWNaaaaaa"
          end
          
          if vehicle.actual_price.present?
            xml.price vehicle.actual_price.to_s + " USD"
          elsif vehicle.msrp.present?
            xml.price vehicle.msrp.to_s + " USD"
          else
            xml.price "0 USD"
          end
          
          if vehicle.color.present?
            xml.exterior_color vehicle.color
          else
            xml.exterior_color "Unknown"
          end
          
          if vehicle.condition == "New"
            xml.state_of_vehicle "NEW"
          else
            xml.state_of_vehicle "USED"
          end
          
          if vehicle.vehicle_model.present?
            xml.custom_label_0 vehicle.vehicle_model.vehicle_type
          elsif vehicle.body_style.present?
            xml.custom_label_0 vehicle.body_style
          else
            xml.custom_label_0 "Other"
          end
        end
      end
    end
  end
end