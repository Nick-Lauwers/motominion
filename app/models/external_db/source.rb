module ExternalDb
  class Source < Record
    
    self.table_name = 'source'
    has_many :vehicles

    def sync_to_dealership 
      if vehicles.where(vehicle_type_id: [3, 4]).exists?
        ::Dealership.where(scraped_id: id).first_or_initialize.tap do |d|
          d.scrape_name = scrape_name
          d.last_run_start_at = last_run_start
          d.last_run_end_at = last_run_end
          d.last_run_total_records= last_run_total_records
          d.last_run_new_records = last_run_new_records
          d.last_run_duplicate_records = last_run_duplicate_records
          d.last_run_error_records = last_run_error_records
          d.save
        end
      end
    end
  end
end