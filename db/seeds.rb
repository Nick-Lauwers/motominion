# seed data for comments (Listing 13.25)

# Users
User.create!(name:   "Example User",
             email:  "example@railstutorial.org",
             password:               "foobar",
             password_confirmation:  "foobar", 
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
             
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Vehicles
users = User.order(:created_at).take(6)
50.times do
  users.each { |user| user.vehicles.create!(vehicle_condition:           "New",
                                            body_style:                  "Pickup",
                                            color:                       "Gray",
                                            transmission:                "Automatic",
                                            fuel_type:                   "Flex Fuel",
                                            drivetrain:                  "All-Wheel Drive",
                                            vin:                         "2G1FK3DJ0F9298212",
                                            listing_name:                Faker::Lorem.word,
                                            address:                     "262 Hudson Crescent, Wallaceburg ON",
                                            year:                        2014,
                                            price:                       Faker::Number.number(5),
                                            mileage:                     Faker::Number.number(5),
                                            seating_capacity:            5,
                                            summary:                     Faker::Lorem.sentence, 
                                            sellers_notes:               Faker::Lorem.sentence, 
                                            is_leather_seats:            true,
                                            is_sunroof:                  true,
                                            is_navigation_system:        true,
                                            is_dvd_entertainment_system: false,
                                            is_bluetooth:                true,
                                            is_backup_camera:            true,
                                            is_remote_start:             true,
                                            is_tow_package:              true,
                                            is_autonomy:                 false) }
end

# Photos
vehicle = Vehicle.all.last
8.times do 
    vehicle.photos.create!(image: File.new("app/assets/images/gallery1.jpg"))
end

# Comments
user    = User.all.last
vehicle = Vehicle.all.last
3.times do
  vehicle.comments.create!(title:   Faker::Lorem.word,
                           content: Faker::Lorem.sentence,
                           likes:   5,
                           user:    user)
end

# Replies
user    = User.all.last
comment = Comment.all.last
3.times do
  comment.replies.create!(content: Faker::Lorem.sentence,
                          likes:   5,
                          user:    user)
end
  

# Appointments
# users.each { 
#     users.each { |user| user.vehicles.order(:created_at).take(1) }
#              user.vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
#                                                     date:       Faker::Date.forward(10)) }
# }

# vehicles = users.each { |user| user.vehicles.order(:created_at).take(1) }
# vehicle.id = vehicles.each { |vehicle| vehicle.id }
# users.each { |user| user.appointments.create!(vehicle_id: vehicle.id,
#                                                     date:       Faker::Date.forward(10)) }


# vehicles = users.each { |user| user.vehicles.order(:created_at).take(1) }
# users.each {
#     vehicles.each { |vehicle| users.appointments.create!(vehicle_id: vehicle.id,
#                                                     date:       Faker::Date.forward(10)) }
# }


# users.each { |user| vehicles  = user.vehicles.order(:created_at).take(1) 
#              vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
#                                                     date:       Faker::Date.forward(10)) }
# }

# users     = User.all
# user      = users.first
# vehicles  = Vehicle.take(6)
# vehicles.each { |vehicle| user.appointments.create!(vehicle_id: vehicle.id,
#                                                     date:       Faker::Date.forward(10)) }

users     = User.all
user1      = users.first
user2      = users.second
vehicle1s    = user1.vehicles.order(:created_at).take(1)
vehicle2s    = user2.vehicles.order(:created_at).take(1)
vehicle2s.each { |vehicle2| user1.appointments.create!(vehicle_id: vehicle2.id,
                                                    date:       Faker::Date.forward(10)) }
vehicle1s.each { |vehicle1| user2.appointments.create!(vehicle_id: vehicle1.id,
                                                    date:       Faker::Date.forward(10)) }