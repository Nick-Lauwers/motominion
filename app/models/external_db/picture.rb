module ExternalDb
  class Picture < Record
    self.table_name = 'picture'
    belongs_to :vehicle

    def sync_to_photo
      if ( vehicle.vehicle_type_id == 3 || vehicle.vehicle_type_id == 4 )
        
        if ::Photo.where(scraped_id: id).exists?
          ::Photo.where(scraped_id: id).first.tap do |p|
            p.last_found_at = last_found
            p.save or nil
          end
        
        else
          ::Photo.new(scraped_id: id).tap do |p|
            p.vehicle = ::Vehicle.where(scraped_id: vehicle_id).first
            p.image = open(image_url) rescue nil
            p.last_found_at = last_found
            p.save or nil
          end
        end 
      end
    end
  end
end