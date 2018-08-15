task :synchronize => :environment do
  
  ExternalDb::Source.all.each(&:sync_to_dealership)
  # ExternalDb::Vehicle.all.each(&:sync_to_vehicle)
  # ExternalDb::Picture.all.each(&:sync_to_photo)
  
  # Vehicle.all.each do |v|
              
  #   if v.photos.count.between?(1,3)
  #     v.listing_score.update_attribute(:photos_score, 33)
  #   elsif v.photos.count.between?(4,7)
  #     v.listing_score.update_attribute(:photos_score, 67)
  #   elsif v.photos.count >= 8
  #     v.listing_score.update_attribute(:photos_score, 100)
  #   end
    
  #   v.listing_score do |l|
      
  #     overall_score = ( l.location_score + l.features_score + l.spec_score + 
  #                       l.vin_score + l.certified_dealer_score +
  #                       l.direct_listing_score + l.test_drive_score + 
  #                       ( 3 * l.photos_score ) +
  #                       # l.reviews_score + 
  #                       l.recently_posted_score + l.many_listings_score ) / 12
      
  #     l.update_attribute(:overall_score, overall_score)
  #   end
  # end
end