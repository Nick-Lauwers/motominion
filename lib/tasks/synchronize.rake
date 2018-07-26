task :synchronize => :environment do
  
  ExternalDb::Source.all.each(&:sync_to_dealership)
  ExternalDb::Vehicle.all.each(&:sync_to_vehicle)
  ExternalDb::Picture.all.each(&:sync_to_photo)
  
  Vehicle.all.each do |v|
              
    if v.photos.count.between?(1,3)
      v.listing_score.update_attribute(photos_score: 33)
    elsif p.vehicle.photos.count.between?(4,7)
      v.listing_score.update_attribute(photos_score: 67)
    elsif p.vehicle.photos.count >= 8
      v.listing_score.update_attribute(photos_score: 100)
    end
    
    v.listing_score.update_attribute(overall_score: 
                                  ( v.listing_score.location_score + 
                                    v.listing_score.features_score + 
                                    v.listing_score.spec_score + 
                                    v.listing_score.vin_score + 
                                    v.listing_score.certified_dealer_score +
                                    v.listing_score.direct_listing_score +
                                    v.listing_score.test_drive_score + 
                                    ( 3 * v.listing_score.photos_score ) +
                                    # v.listing_score.reviews_score + 
                                    v.listing_score.recently_posted_score + 
                                    v.listing_score.many_listings_score ) / 12 )
  end
end