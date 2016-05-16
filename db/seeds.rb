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

users = User.order(:created_at).take(6)
50.times do
  users.each { |user| user.vehicles.create!(body_style:         "Pickup",
                                            passenger_capacity: 5,
                                            exterior_color:     "Black Granite Metallic",
                                            interior_color:     "Ebony",
                                            wheel:              "20in Alloy Wheels",
                                            tire:               "P275/55",
                                            fuel_type:          "Flex Fuel (Unleaded/E85)",
                                            engine:             "Vortec 5.3L Flex Fuel V8",
                                            transmission:       "6-Speed Shiftable Automatic",
                                            vin:                "2G1FK3DJ0F9298212",
                                            listing_name:       Faker::Lorem.word,
                                            summary:            Faker::Lorem.sentence,
                                            address:            Faker::Address.street_address,
                                            price:              Faker::Number.number(5)) }
end