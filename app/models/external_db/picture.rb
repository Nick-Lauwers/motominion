module ExternalDb
  class Picture < Record
    self.table_name = 'picture'
    belongs_to :vehicle

    def sync_to_photo
      ::Photo.where(scraped_id: id).first_or_initialize.tap do |p|
        p.vehicle = vehicle.sync_to_vehicle if vehicle
        p.image = open(image_url) rescue nil
        # p.image = open(image_url.gsub! 'edealer.ca/2/', 'edealer.ca/1/') rescue nil
        p.last_found_at = last_found
        p.save or nil
      end
    end
  end
end