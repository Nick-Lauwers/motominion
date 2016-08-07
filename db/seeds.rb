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
  users.each { |user| user.vehicles.create!(body_style:         "Pickup",
                                            seating_capacity:   5,
                                            color:              "Gray",
                                            wheel:              "20in Alloy Wheels",
                                            tire:               "P275/55",
                                            fuel_type:          "Flex Fuel",
                                            engine:             "Vortec 5.3L Flex Fuel V8",
                                            vin:                "2G1FK3DJ0F9298212",
                                            listing_name:       Faker::Lorem.word,
                                            summary:            Faker::Lorem.sentence,
                                            address:            Faker::Address.street_address,
                                            price:              Faker::Number.number(5),
                                            vehicle_condition:  "New",
                                            mileage:            Faker::Number.number(5),
                                            year:               2014,
                                            transmission:       "Automatic",
                                            drivetrain:         "All-Wheel Drive"
                                            ) }
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