class ListingScore < ActiveRecord::Base
  
  belongs_to :vehicle
  
  validates :vehicle_id, :location_score, :features_score, :spec_score,
            :vin_score, :certified_dealer_score, :direct_listing_score,
            :test_drive_score, :photos_score, :recently_posted_score, 
            :many_listings_score, :overall_score, presence: true
end