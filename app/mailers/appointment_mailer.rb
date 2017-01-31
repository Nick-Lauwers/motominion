class AppointmentMailer < ApplicationMailer

  def appointment_request(appointment)
    
    @vehicle      = appointment.vehicle
    @seller       = appointment.vehicle.user
    @customer     = appointment.user
    @conversation = Conversation.between(@seller, @customer).first

    mail to: appointment.vehicle.user.email, subject: "Test Drive Request"
  end
  
  def appointment_accepted(appointment)
    @vehicle      = appointment.vehicle
    @customer     = appointment.user
    
    mail to: appointment.user.email, 
    subject: "Test Drive Request Accepted"
  end
  
  def appointment_declined(appointment)
    @vehicle      = appointment.vehicle
    @customer     = appointment.user
    
    mail to: appointment.user.email, 
    subject: "Test Drive Request Declined"
  end
end
