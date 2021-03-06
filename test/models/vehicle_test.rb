require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:nicholas)
    @vehicle = @user.vehicles.build(vehicle_condition:      "New",
                                    body_style:             "Coupe",
                                    color:                  "Blue",
                                    transmission:           "Automatic",
                                    fuel_type:              "Gasoline",
                                    drivetrain:             "Front-Wheel Drive",
                                    vin:                    "3GNMCGE06BG101575",
                                    listing_name:           "Chevrolet Malibu", 
                                    address:                "254 Hudson 
                                                            Crescent, 
                                                            Wallaceburg ON", 
                                    year:                   2014,
                                    price:                  25600,
                                    mileage:                27000,
                                    seating_capacity:       4, 
                                    summary:                "Purchase as early 
                                                            as today.",
                                    sellers_notes:          "Must sell vehicle 
                                                            immediately.",
                                    is_leather_seats:       false,
                                    is_sunroof:             false,
                                    is_navigation_system:   true,
                                    is_dvd_entertainment_system: false,
                                    is_bluetooth:           true,
                                    is_backup_camera:       true,
                                    is_remote_start:        true,
                                    is_tow_package:         false,
                                    is_autonomy:            false,
                                    monday_availability:    "5PM - 9PM",
                                    tuesday_availability:   "5PM - 9PM",
                                    wednesday_availability: "5PM - 9PM",
                                    thursday_availability:  "5PM - 9PM",
                                    friday_availability:    "5PM - 9PM",
                                    saturday_availability:  "5PM - 9PM",
                                    sunday_availability:    "5PM - 9PM")
  end
  
  test "should be valid" do
    assert @vehicle.valid?
  end
  
  test "user id should be present" do
    @vehicle.user_id = nil
    assert_not @vehicle.valid?
  end
  
  test "vin validation should accept valid entries" do
    valid_vins = %w[3GNMCGE06BG101575 Wba3B5C57Ff960849]
    valid_vins.each do |valid_vin|
      @vehicle.vin = valid_vin
      assert @vehicle.valid?, "#{valid_vin.inspect} should be valid"
    end
  end
  
  test "vin validation should reject invalid entries" do
    invalid_vins = ["a" * 16, "b" * 18, "IOQ456786BG101575", 
                    "3GNMCGE0ABG101575", "3GNMCGE06IO101575",
                    "3GNMCGE06IOAAAAAA"]
    invalid_vins.each do |invalid_vin|
      @vehicle.vin = invalid_vin
      assert_not @vehicle.valid?, "#{invalid_vin.inspect} should be invalid"
    end
  end
  
  test "vins should be saved as upper-case" do
    mixed_case_vin = "3gnMCGe06Bg101575"
    @vehicle.vin = mixed_case_vin
    @vehicle.save
    assert_equal mixed_case_vin.upcase, @vehicle.reload.vin
  end
  
  test "listing_name should be at most 30 characters" do
    @vehicle.listing_name = "a" * 31
    assert_not @vehicle.valid?
  end
  
  test "summary should be at most 600 characters" do
    @vehicle.summary = "a" * 601
    assert_not @vehicle.valid?
  end
  
  test "sellers_notes should be at most 600 characters" do
    @vehicle.sellers_notes = "a" * 601
    assert_not @vehicle.valid?
  end
  
  test "availabilities should be at most 30 characters" do
    @vehicle.monday_availability    = "a" * 31
    @vehicle.tuesday_availability   = "a" * 31
    @vehicle.wednesday_availability = "a" * 31
    @vehicle.thursday_availability  = "a" * 31
    @vehicle.friday_availability    = "a" * 31
    @vehicle.saturday_availability  = "a" * 31
    @vehicle.sunday_availability    = "a" * 31
    assert_not @vehicle.valid?
  end
  
  test "order should be most recent first" do
    assert_equal vehicles(:most_recent), Vehicle.first
  end
  
  test "associated appointments should be destroyed" do
    @vehicle.save
    @vehicle.appointments.create!(user_id: 100, date: Time.zone.now)
    assert_difference 'Appointment.count', -1 do
      @vehicle.destroy
    end
  end
  
  test "associated photos should be destroyed" do
    @vehicle.save
    @vehicle.photos.create!(image: appointment_photo("fixture-photo.jpg"))
    assert_difference 'Photo.count', -1 do
      @vehicle.destroy
    end
  end
  
  test "associated comments should be destroyed" do
    @vehicle.save
    @vehicle.comments.create!(title:   "Lorem ipsum",
                              content: "Lorem ipsum",
                              likes:   1,
                              user_id: @user.id)
    assert_difference 'Comment.count', -1 do
      @vehicle.destroy
    end
  end
  
  test "associated favorite vehicles should be destroyed" do
    @vehicle.save
    @vehicle.favorite_vehicles.create!(user_id: 100)
    assert_difference 'FavoriteVehicle.count', -1 do
      @vehicle.destroy
    end
  end
end