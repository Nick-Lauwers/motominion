require 'test_helper'

class AppointmentMailerTest < ActionMailer::TestCase
  test "appointment_request" do
    appointment = appointments(:latest_appointment)
    mail = AppointmentMailer.appointment_request(appointment)
    assert_equal "Appointment Request",                       mail.subject
    assert_equal [appointment.vehicle.user.email],            mail.to
    assert_equal ["noreply@example.com"],                     mail.from
    assert_match appointment.vehicle.user.name,               mail.body.encoded
  end
  
  test "appointment_accepted" do
    appointment = appointments(:soonest_appointment)
    mail = AppointmentMailer.appointment_accepted(appointment)
    assert_equal "Appointment Accepted",                      mail.subject
    assert_equal [appointment.vehicle.user.email],            mail.to
    assert_equal ["noreply@example.com"],                     mail.from
    assert_match appointment.vehicle.user.name,               mail.body.encoded
  end
  
  test "appointment_declined" do
    appointment = appointments(:later_appointment)
    mail = AppointmentMailer.appointment_declined(appointment)
    assert_equal "Appointment Declined",                      mail.subject
    assert_equal [appointment.vehicle.user.email],            mail.to
    assert_equal ["noreply@example.com"],                     mail.from
    assert_match appointment.vehicle.user.name,               mail.body.encoded
  end
end
