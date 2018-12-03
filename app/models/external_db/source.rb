module ExternalDb
  class Source < Record
    
    self.table_name = 'source'
    has_many :vehicles

    def sync_to_dealership 
      if vehicles.where(vehicle_type_id: [3, 4]).exists?
        
        if ::Dealership.where(scraped_id: id).exists?
          ::Dealership.where(scraped_id: id).first.tap do |d|
        
            d.last_run_start_at = last_run_start
            d.last_run_end_at = last_run_end
            d.last_run_total_records= last_run_total_records
            d.last_run_new_records = last_run_new_records
            d.last_run_duplicate_records = last_run_duplicate_records
            d.last_run_error_records = last_run_error_records
        
            # if d.google_place_id.present?
              
            #   g = GooglePlaces::Client.
            #         new(ENV['GOOGLE_API_KEY']).
            #         spot(d.google_place_id)
                
            #   d.google_place_rating = g.rating
            # end
            
            d.save
            
            puts "Dealership #{id} modified."
          end
        
        else
          ::Dealership.where(scraped_id: id).first_or_initialize.tap do |d|
            
            d.scrape_name = scrape_name
            d.last_run_start_at = last_run_start
            d.last_run_end_at = last_run_end
            d.last_run_total_records= last_run_total_records
            d.last_run_new_records = last_run_new_records
            d.last_run_duplicate_records = last_run_duplicate_records
            d.last_run_error_records = last_run_error_records
            
            if id == 2
              # Munroe Motors
              d.google_place_id = 'ChIJ0Tj1JiJ-j4AR7INR_HiJchM'
            elsif id == 3
              # Scuderia West
              d.google_place_id = 'ChIJ-dnDWyB-j4ARjDdZu1J74J0'
            end
            
            d.save
            
            puts "Dealership #{id} added."
            
            # if d.google_place_id.present?
              
            #   g = GooglePlaces::Client.
            #         new(ENV['GOOGLE_API_KEY']).
            #         spot(d.google_place_id)
                
            #   d.google_place_rating = g.rating
            #   d.save
                
            #   g.reviews.each do |r|
            #     d.google_reviews.create(author_name:       r.author_name,
            #                             profile_photo_url: r.profile_photo_url,
            #                             rating:            r.rating,
            #                             text:              r.text,
            #                             time:              r.time)
            #   end
            end
          end
        end
      end
    end
  end
end