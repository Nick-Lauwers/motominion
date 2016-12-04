class AppointmentMailer < ApplicationMailer

  def appointment_request(appointment)
    @seller = appointment.vehicle.user
    mail to: appointment.vehicle.user.email, subject: "Appointment Request"
  end
end
