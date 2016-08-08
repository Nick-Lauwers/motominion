require 'test_helper'

class VehiclesControllerTest < ActionController::TestCase

  def setup
    @vehicle = vehicles(:avalanche)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Vehicle.count' do
      post :create, vehicle: { vehicle_condition: "New",
                               body_style: "Hatchback",
                               color: "Gray",
                               transmission: "Automatic",
                               fuel_type: "Hybrid",
                               drivetrain: "Front-Wheel Drive",
                               vin: "JTDKN3DP6D3037738",
                               listing_name: "Toyota Prius Plug-In Hybrid", 
                               address: "262 Hudson Crescent, Wallaceburg ON",
                               year: 2014,
                               price: 17250,
                               mileage: 27000, 
                               seating_capacity: 5, 
                               summary: "Adds high-capacity battery power to the 
                                         Prius' traditional benefits.",
                               sellers_notes: "Must be sold quickly.",
                               is_leather_seats: true,
                               is_sunroof: true,
                               is_navigation_system: true,
                               is_dvd_entertainment_system: false,
                               is_bluetooth: true,
                               is_backup_camera: true,
                               is_remote_start: true,
                               is_tow_package: false,
                               is_autonomy: false }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Vehicle.count' do
      delete :destroy, id: @vehicle
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect index when not logged in" do
    get :index, id: @vehicle
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @vehicle
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    get :update, id: @vehicle
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end