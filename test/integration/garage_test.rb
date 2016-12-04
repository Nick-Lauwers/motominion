# complete

require 'test_helper'

class GarageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:nicholas)
  end
  
  test "garage display" do
    log_in_as(@user)
    get vehicles_path
    assert_template 'vehicles/index'
    assert_select 'title', full_title("Garage")
    assert_select "a[href=?]", vehicles_path
    assert_select "a[href=?]", test_drives_path
    assert_select "a[href=?]", customers_path
    assert_match @user.vehicles.count.to_s, response.body
    @user.vehicles.each do |vehicle|
      assert_match vehicle.listing_name, response.body
    end
  end
end