require 'test_helper'

class FavoriteVehicleTest < ActiveSupport::TestCase
  
  def setup
    @user             = users(:archer)
    @vehicle          = vehicles(:avalanche)
    @favorite_vehicle = @user.favorite_vehicles.build(vehicle_id: @vehicle.id)
  end
  
  test "should be valid" do
    assert @favorite_vehicle.valid?
  end
  
  test "user id should be present" do
    @favorite_vehicle.user_id = nil
    assert_not @favorite_vehicle.valid?
  end
  
  test "vehicle id should be present" do
    @favorite_vehicle.vehicle_id = nil
    assert_not @favorite_vehicle.valid?
  end
end
