class AppointmentMailer < ApplicationMailer

  def appointment_request(appointment)
    
    @vehicle      = appointment.vehicle
    @seller       = appointment.vehicle.user
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first

    mail to: appointment.buyer.email, subject: "Test Drive Request"
  end
  
  def appointment_accepted(appointment)
    
    @vehicle      = appointment.vehicle
    @seller       = appointment.vehicle.user
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first
    
    mail to: appointment.buyer.email, 
    subject: "Test Drive Request Accepted"
  end
  
  def appointment_declined(appointment)
    
    @vehicle      = appointment.vehicle
    @seller       = appointment.vehicle.user
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first
    
    mail to: appointment.buyer.email, 
    subject: "Test Drive Request Declined"
  end
  
  def review_request(appointment)
    @appointment = appointment
    mail to: appointment.buyer.email, subject: "Write A Review!"
  end
end