class AppointmentMailer < ApplicationMailer

  def appointment_request(appointment)
    
    @vehicle  = appointment.vehicle
    @seller   = appointment.vehicle.user
    @customer = appointment.user
    
    mail to: appointment.vehicle.user.email, subject: "Appointment Request"
  end
end
