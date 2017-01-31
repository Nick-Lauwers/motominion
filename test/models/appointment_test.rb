require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  
  def setup
    @vehicle = vehicles(:avalanche)
    @user    = users(:archer)
    
    @appointment = Appointment.new(status:     "accepted", 
                                   date:       Time.zone.now, 
                                   user_id:    @user.id, 
                                   vehicle_id: @vehicle.id)
  end
  
  test "should be valid" do
    @appointment.valid?
  end
  
  test "should require a status" do
    @appointment.status = nil
    assert_not @appointment.valid?
  end
  
  test "should require a date" do
    @appointment.date = nil
    assert_not @appointment.valid?
  end
  
  test "should require a user id" do
    @appointment.user_id = nil
    assert_not @appointment.valid?
  end

  test "should require a vehicle id" do
    @appointment.vehicle_id = nil
    assert_not @appointment.valid?
  end
  
  test "order should be most recent first" do
    assert_equal appointments(:soonest_appointment), Appointment.first
  end
end