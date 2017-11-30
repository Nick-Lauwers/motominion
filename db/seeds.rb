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
    user.avatar                = open(row[10])
    user.dealership_id         = row[11]
    user.dealership_admin      = row[12]
  end
end

# Vehicles
CSV.foreach(Rails.root.join("vehicles.csv"), headers: true) do |row|
  Vehicle.create! do |vehicle|
    vehicle.id                          = row[0]
    vehicle.body_style                  = row[1]
    vehicle.color                       = row[2]
    vehicle.transmission                = row[3]
    vehicle.fuel_type                   = row[4]
    vehicle.drivetrain                  = row[5]
    vehicle.vin                         = row[6]
    vehicle.listing_name                = row[7]
    vehicle.street_address              = row[8]
    vehicle.apartment                   = row[9]
    vehicle.city                        = row[10]
    vehicle.state                       = row[11]
    vehicle.year                        = row[12]
    vehicle.price                       = row[13]
    vehicle.mileage                     = row[14]
    vehicle.seating_capacity            = row[15]
    vehicle.summary                     = row[16]
    vehicle.sellers_notes               = row[17]
    vehicle.is_leather_seats            = row[18]
    vehicle.is_sunroof                  = row[19]
    vehicle.is_navigation_system        = row[20]
    vehicle.is_dvd_entertainment_system = row[21]
    vehicle.is_bluetooth                = row[22]
    vehicle.is_backup_camera            = row[23]
    vehicle.is_remote_start             = row[24]
    vehicle.is_tow_package              = row[25]
    vehicle.user_id                     = row[26]
    vehicle.vehicle_make_id             = row[27]
    vehicle.vehicle_model_id            = row[28]
    vehicle.latitude                    = row[29]
    vehicle.longitude                   = row[30]
    vehicle.bumped_at                   = row[31]
    vehicle.posted_at                   = row[32]
  end
end

# Photos
CSV.foreach(Rails.root.join("photos.csv"), headers: true) do |row|
  Photo.create! do |photo|
    photo.vehicle_id = row[0]
    photo.image      = open(row[1])
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
    discussion_comment.comment       = row[0]
    discussion_comment.discussion_id = row[1]
    discussion_comment.user_id       = row[2]
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

# Dealerships
CSV.foreach(Rails.root.join("dealerships.csv"), headers: true) do |row|
  Dealership.create! do |dealership|
    dealership.id             = row[0]
    dealership.name           = row[1]
    dealership.email          = row[2]
    dealership.activated      = row[3]
    dealership.activated_at   = row[4]
    dealership.description    = row[5]
    dealership.website        = row[6]
    dealership.sales_phone    = row[7]
    dealership.service_phone  = row[8]
    dealership.street_address = row[9]
    dealership.building       = row[10]
    dealership.city           = row[11]
    dealership.state          = row[12]
    dealership.latitude       = row[13]
    dealership.longitude      = row[14]
    dealership.logo           = open(row[15])
    dealership.photo          = open(row[16])
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