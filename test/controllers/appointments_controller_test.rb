require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  
  def setup
    @vehicle     = vehicles(:avalanche)
    @appointment = appointments(:soonest_appointment)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Appointment.count' do
      post :create, vehicle_id: @vehicle.id, 
        appointment: { date: Faker::Date.forward(10) }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Appointment.count' do
      post :destroy, vehicle_id: @vehicle.id, id: @appointment
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect garage when not logged in" do
    get :test_drives
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect customers when not logged in" do
    get :customers
    assert_not flash.empty?
    assert_redirected_to login_url    
  end
end