task :update_scores => :environment do
  
  Vehicle.all.each do |v|
              
    # Listing location is an exact address
    if v.latitude.present?
      location_score = 100
    else
      location_score = 0
    end
      
    # Features are properly noted.
    if v.cruise_control || v.am_fm || v.cb_radio || v.navigation_system || 
       v.heated_seats || v.heated_hand_grips || v.alarm_system || 
       v.saddlebags || v.trunk || v.tow_hitch || v.cycle_cover
      features_score = 100
        
    else
      features_score = 0
    end
      
    # Specifications are properly noted.
    spec_score = 0
    
    spec_score += 1 if v.color.present?
    spec_score += 1 if v.engine_type.present?
    spec_score += 1 if v.fuel_type.present?
    spec_score += 1 if v.engine_size.present?
    
    spec_score = 25 * spec_score
      
    # VIN is properly noted.
    if v.vin.present?
      vin_score = 100
    else
      vin_score = 0
    end
      
    # Vehicle is listed by a certified dealer and dealership sends a direct
    # feed.
    if v.dealership.present? && v.dealership.scraped_id.present?
      certified_dealer_score = 100
      direct_listing_score = 100
    
    elsif v.dealership.present?
      certified_dealer_score = 0
      direct_listing_score = 0
      
    else
      certified_dealer_score = 100
      direct_listing_score = 100
    end 
      
    # Seller accepts test drives, on-demand.
    test_drive_score = 100
      
    # Listing has many photos.
    if v.photos.count == 0
      photos_score = 0
    elsif v.photos.count.between?(1,3)
      photos_score = 33
    elsif v.photos.count.between?(4,7)
      photos_score = 67
    else
      photos_score = 100
    end
      
    # Seller has several positive reviews.
      
    # Listing was recently posted or bumped.
    if v.bumped_at >= 1.day.ago
      recently_posted_score = 100
    elsif v.bumped_at >= 3.days.ago
      recently_posted_score = 67
    else
      recently_posted_score = 33
    end
      
    # Seller has many high-quality listings.
    # combined_score = 0

    # v.dealership.vehicles.each do |vehicle|
    #   combined_score = vehicle.listing_score.overall_score + 
    #                     combined_score
    # end
    
    # if combined_score/(v.dealership.vehicles.count) <= 59
    #   many_listings_score = 33
    # elsif combined_score/(v.dealership.vehicles.count) <= 79
    #   many_listings_score = 67
    # else 
    #   many_listings_score = 100
    # end
    many_listings_score = 100
      
    # Calculate overall score.
    overall_score = ( location_score + features_score + spec_score + vin_score + 
                      certified_dealer_score + direct_listing_score +
                      test_drive_score + ( 3 * photos_score ) +
                      # score.reviews_score + 
                      ( 2 * recently_posted_score ) + many_listings_score ) / 13
      
    if v.listing_score.present?
      v.listing_score.update_attributes(
        location_score:         location_score,
        features_score:         features_score,
        spec_score:             spec_score,
        vin_score:              vin_score,
        certified_dealer_score: certified_dealer_score,
        direct_listing_score:   direct_listing_score,
        test_drive_score:       test_drive_score,
        photos_score:           photos_score,
        # reviews_score:        reviews_score,
        recently_posted_score:  recently_posted_score,
        many_listings_score:    many_listings_score,
        overall_score: overall_score
      )
      
    else                             
      v.build_listing_score(
        location_score:         location_score, 
        features_score:         features_score,
        spec_score:             spec_score, 
        vin_score:              vin_score, 
        certified_dealer_score: certified_dealer_score,
        direct_listing_score:   direct_listing_score,
        test_drive_score:       test_drive_score, 
        photos_score:           photos_score,
        # reviews_score:        reviews_score, 
        recently_posted_score:  recently_posted_score,
        many_listings_score:    many_listings_score, 
        overall_score:          overall_score
      )
    end
  end
end