require 'csv'

# Makes
CSV.foreach(Rails.root.join("vehicle_makes.csv"), headers: true) do |row|
  VehicleMake.create! do |vehicle_make|
    vehicle_make.id              = row[0]
    vehicle_make.name            = row[1]
    vehicle_make.cover_photo_url = row[2]
  end
end

# Models
CSV.foreach(Rails.root.join("vehicle_models.csv"), headers: true) do |row|
  VehicleModel.create! do |vehicle_model|
    vehicle_model.id              = row[0]
    vehicle_model.name            = row[1]
    vehicle_model.vehicle_make_id = row[2]
  end
end

# Series
CSV.foreach(Rails.root.join("vehicle_series.csv"), headers: true) do |row|
  VehicleSeries.create! do |vehicle_series|
    vehicle_series.id               = row[0]
    vehicle_series.name             = row[1]
    vehicle_series.vehicle_model_id = row[2]
  end
end

# Trims
CSV.foreach(Rails.root.join("vehicle_trims.csv"), headers: true) do |row|
  VehicleTrim.create! do |vehicle_trim|
    vehicle_trim.id                    = row[0]
    vehicle_trim.vehicle_series_id     = row[1]
    vehicle_trim.name                  = row[2]
    vehicle_trim.first_production_year = row[3]
    vehicle_trim.last_production_year  = row[4]
  end
end

# Specifications
CSV.foreach(Rails.root.join("vehicle_specifications.csv"), headers: true) do |row|
  VehicleSpecification.create! do |vehicle_specification|
    vehicle_specification.id       = row[0]
    vehicle_specification.name     = row[1]
    vehicle_specification.class_id = row[2]
  end
end

# Specification Values
CSV.foreach(Rails.root.join("vehicle_specification_values.csv"), headers: true) do |row|
  VehicleSpecificationValue.create! do |vehicle_specification_value|
    vehicle_specification_value.id                       = row[0]
    vehicle_specification_value.vehicle_trim_id          = row[1]
    vehicle_specification_value.vehicle_specification_id = row[2]
    vehicle_specification_value.value                    = row[3]
    vehicle_specification_value.unit                     = row[4]
  end
end

# Dealerships
CSV.foreach(Rails.root.join("dealerships.csv"), headers: true) do |row|
  Dealership.create! do |dealership|
    dealership.id                         = row[0]
    dealership.dealership_name            = row[1]
    dealership.scrape_name                = row[2]
    dealership.email                      = row[3]
    dealership.activated                  = row[4]
    dealership.activated_at               = row[5]
    dealership.description                = row[6]
    dealership.website                    = row[7]
    dealership.sales_phone                = row[8]
    dealership.service_phone              = row[9]
    dealership.street_address             = row[10]
    dealership.building                   = row[11]
    dealership.city                       = row[12]
    dealership.state                      = row[13]
    dealership.latitude                   = row[14]
    dealership.longitude                  = row[15]
    dealership.logo                       = open(row[16]) unless row[16].nil?
    dealership.photo                      = open(row[17]) unless row[17].nil?
    dealership.last_run_start_at          = row[18]
    dealership.last_run_end_at            = row[19]
    dealership.last_run_total_records     = row[20]
    dealership.last_run_new_records       = row[21]
    dealership.last_run_duplicate_records = row[22]
    dealership.last_run_error_records     = row[23]
  end
end

# Users
CSV.foreach(Rails.root.join("users.csv"), headers: true) do |row|
  User.create! do |user|
    user.id                    = row[0]
    user.first_name            = row[1]
    user.last_name             = row[2]
    user.email                 = row[3]
    user.password              = row[4]
    user.password_confirmation = row[5]
    user.is_subscribed         = row[6]
    user.admin                 = row[7]
    user.activated             = row[8]
    user.activated_at          = row[9]
    user.avatar                = open(row[10]) unless row[10].nil?
    user.dealership_id         = row[11]
    user.dealership_admin      = row[12]
  end
end

# Vehicles
CSV.foreach(Rails.root.join("vehicles.csv"), headers: true) do |row|
  Vehicle.create! do |vehicle|
    vehicle.id                 = row[0]
    vehicle.dealership_id      = row[1]
    vehicle.user_id            = row[2]
    vehicle.listing_name       = row[3]
    vehicle.vehicle_make_name  = row[4]
    vehicle.vehicle_make_id    = row[5]
    vehicle.vehicle_model_name = row[6]
    vehicle.vehicle_model_id   = row[7]
    vehicle.msrp               = row[8]
    vehicle.actual_price       = row[9]
    vehicle.year               = row[10]
    vehicle.mileage            = row[11]
    vehicle.mileage_numeric    = row[12]
    vehicle.body_style         = row[13]
    vehicle.color              = row[14]
    vehicle.engine_type        = row[15]
    vehicle.fuel_type          = row[16]
    vehicle.vin                = row[17]
    vehicle.engine_size        = row[18]
    vehicle.description        = row[19]
    vehicle.description_clean  = row[20]
    vehicle.cruise_control     = row[21]
    vehicle.am_fm              = row[22]
    vehicle.cb_radio           = row[23]
    vehicle.navigation_system  = row[24]
    vehicle.heated_seats       = row[25]
    vehicle.heated_hand_grips  = row[26]
    vehicle.alarm_system       = row[27]
    vehicle.saddlebags         = row[28]
    vehicle.trunk              = row[29]
    vehicle.tow_hitch          = row[30]
    vehicle.cycle_cover        = row[31]
    vehicle.street_address     = row[32]
    vehicle.apartment          = row[33]
    vehicle.city               = row[34]
    vehicle.state              = row[35]
    vehicle.latitude           = row[36]
    vehicle.longitude          = row[37]
    vehicle.ad_url             = row[38]
    vehicle.created_at         = row[39]
    vehicle.posted_at          = row[40]
    vehicle.bumped_at          = row[41]
    vehicle.last_found_at      = row[42]
  end
end

# Listing Scores
CSV.foreach(Rails.root.join("listing_scores.csv"), headers: true) do |row|
  ListingScore.create! do |listing_score|
    listing_score.id                     = row[0]
    listing_score.vehicle_id             = row[1]
    listing_score.location_score         = row[2]
    listing_score.features_score         = row[3]
    listing_score.spec_score             = row[4]
    listing_score.vin_score              = row[5]
    listing_score.certified_dealer_score = row[6]
    listing_score.direct_listing_score   = row[7]
    listing_score.test_drive_score       = row[8]
    listing_score.photos_score           = row[9]
    listing_score.reviews_score          = row[10]
    listing_score.recently_posted_score  = row[11]
    listing_score.many_listings_score    = row[12]
    listing_score.overall_score          = row[13]
  end
end

# Photos
CSV.foreach(Rails.root.join("photos.csv"), headers: true) do |row|
  Photo.create! do |photo|
    photo.vehicle_id = row[0]
    photo.image      = open(row[1]) unless row[1].nil?
  end
end

# Discussions
CSV.foreach(Rails.root.join("discussions.csv"), headers: true) do |row|
  Discussion.create! do |discussion|
    discussion.id              = row[0]
    discussion.title           = row[1]
    discussion.content         = row[2]
    discussion.user_id         = row[3]
    discussion.cached_votes_up = row[4]
  end
end

# Discussion Comments
CSV.foreach(Rails.root.join("discussion_comments.csv"), headers: true) do |row|
  DiscussionComment.create! do |discussion_comment|
    discussion_comment.id            = row[0]
    discussion_comment.comment       = row[1]
    discussion_comment.discussion_id = row[2]
    discussion_comment.user_id       = row[3]
  end
end

# Clubs
CSV.foreach(Rails.root.join("clubs.csv"), headers: true) do |row|
  Club.create! do |club|
    club.id          = row[0]
    club.name        = row[1]
    club.description = row[2]
    club.cover_photo = open(row[3])
    club.city        = row[4]
    club.state       = row[5]
    club.latitude    = row[6]
    club.longitude   = row[7]
  end
end

# Business Hours
CSV.foreach(Rails.root.join("business_hours.csv"), headers: true) do |row|
  BusinessHour.create! do |business_hour|
    business_hour.id            = row[0]
    business_hour.day           = row[1]
    business_hour.open_time     = row[2]
    business_hour.close_time    = row[3]
    business_hour.is_closed     = row[4]
    business_hour.dealership_id = row[5]
  end
end
  
# User.create!(name:   "Example User",
#             email:  "example@railstutorial.org",
#             password:               "foobar",
#             password_confirmation:  "foobar",
#             is_subscribed: true,
#             admin:         true,
#             activated:     true,
#             activated_at: Time.zone.now)

# # seed data for comments (Listing 13.25)

# # Users
# User.create!(name:   "Example User",
#             email:  "example@railstutorial.org",
#             password:               "foobar",
#             password_confirmation:  "foobar",
#             is_subscribed: true,
#             admin:         true,
#             activated:     true,
#             activated_at: Time.zone.now)
             
# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               is_subscribed: false,
#               activated:     true,
#               activated_at: Time.zone.now)
# end

# # Vehicles
# users = User.order(:created_at).take(6)
# 50.times do
#   users.each { |user| user.vehicles.create!(vehicle_condition:           "New",
#                                             body_style:                  "Pickup",
#                                             color:                       "Gray",
#                                             transmission:                "Automatic",
#                                             fuel_type:                   "Flex Fuel",
#                                             drivetrain:                  "All-Wheel Drive",
#                                             vin:                         "2G1FK3DJ0F9298212",
#                                             listing_name:                Faker::Lorem.word,
#                                             address:                     "262 Hudson Crescent, Wallaceburg ON",
#                                             year:                        2014,
#                                             price:                       Faker::Number.number(5),
#                                             mileage:                     Faker::Number.number(5),
#                                             seating_capacity:            5,
#                                             summary:                     Faker::Lorem.sentence, 
#                                             sellers_notes:               Faker::Lorem.sentence, 
#                                             is_leather_seats:            true,
#                                             is_sunroof:                  true,
#                                             is_navigation_system:        true,
#                                             is_dvd_entertainment_system: false,
#                                             is_bluetooth:                true,
#                                             is_backup_camera:            true,
#                                             is_remote_start:             true,
#                                             is_tow_package:              true,
#                                             is_autonomy:                 false) }
# end

# # Photos
# vehicle = Vehicle.all.last
# 8.times do 
#     vehicle.photos.create!(image: File.new("app/assets/images/gallery1.jpg"))
# end

# # Comments
# user    = User.all.last
# vehicle = Vehicle.all.last
# 3.times do
#   vehicle.comments.create!(title:   Faker::Lorem.word,
#                           content: Faker::Lorem.sentence,
#                           likes:   5,
#                           user:    user)
# end

# # Replies
# user    = User.all.last
# comment = Comment.all.last
# 3.times do
#   comment.replies.create!(content: Faker::Lorem.sentence,
#                           likes:   5,
#                           user:    user)
# end
  

# # Appointments
# # users.each { 
# #     users.each { |user| user.vehicles.order(:created_at).take(1) }
# #              user.vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
# #                                                     date:       Faker::Date.forward(10)) }
# # }

# # vehicles = users.each { |user| user.vehicles.order(:created_at).take(1) }
# # vehicle.id = vehicles.each { |vehicle| vehicle.id }
# # users.each { |user| user.appointments.create!(vehicle_id: vehicle.id,
# #                                                     date:       Faker::Date.forward(10)) }


# # vehicles = users.each { |user| user.vehicles.order(:created_at).take(1) }
# # users.each {
# #     vehicles.each { |vehicle| users.appointments.create!(vehicle_id: vehicle.id,
# #                                                     date:       Faker::Date.forward(10)) }
# # }


# # users.each { |user| vehicles  = user.vehicles.order(:created_at).take(1) 
# #              vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
# #                                                     date:       Faker::Date.forward(10)) }
# # }

# # users     = User.all
# # user      = users.first
# # vehicles  = Vehicle.take(6)
# # vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
# #                                                     date:       Faker::Date.forward(10)) }

# users     = User.all
# user1      = users.first
# user2      = users.second
# vehicle1s    = user1.vehicles.order(:created_at).take(1)
# vehicle2s    = user2.vehicles.order(:created_at).take(1)
# vehicle2s.each { |vehicle2| user1.appointments.create!(vehicle_id: vehicle2.id,
#                                                     date:       Faker::Date.forward(10)) }
# vehicle1s.each { |vehicle1| user2.appointments.create!(vehicle_id: vehicle1.id,
#                                                     date:       Faker::Date.forward(10)) }

# User.create(first_name: "Matt", last_name: "Graves", email: "matt@munroemotors.com", password: "98391004", password_confirmation: "98391004", avatar: open("https://randomuser.me/api/portraits/men/31.jpg"), dealership_id: 3)
# User.create(first_name: "Neal", last_name: "Reyes", email: "neal@scuderia.com", password: "98391006", password_confirmation: "98391006", avatar: open("https://randomuser.me/api/portraits/men/94.jpg"), dealership_id: 4)
