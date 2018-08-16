class AppointmentMailer < ApplicationMailer

  def appointment_request(appointment)
    
    @vehicle      = appointment.vehicle
    
    if appointment.vehicle.user.present?
      @seller     = appointment.vehicle.user
    else
      @seller     = appointment.vehicle.dealership.users.first
    end
    
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first

    mail to: @seller.email, subject: "Test Drive Request"
  end
  
  def appointment_request_admin(appointment)
    
    @vehicle      = appointment.vehicle
    
    if appointment.vehicle.user.present?
      @seller     = appointment.vehicle.user
    else
      @seller     = appointment.vehicle.dealership.users.first
    end
    
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first

    mail to: "nlauwers@motominion.com", subject: "Test Drive Request"
  end
  
  def appointment_accepted(appointment)
    
    @vehicle      = appointment.vehicle
    
    if appointment.vehicle.user.present?
      @seller     = appointment.vehicle.user
    else
      @seller     = appointment.vehicle.dealership.users.first
    end
    
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first
    
    mail to: appointment.buyer.email, 
    subject: "Test Drive Request Accepted"
  end
  
  def appointment_declined(appointment)
    
    @vehicle      = appointment.vehicle
    
    if appointment.vehicle.user.present?
      @seller     = appointment.vehicle.user
    else
      @seller     = appointment.vehicle.dealership.users.first
    end
    
    @buyer        = appointment.buyer
    @conversation = Conversation.between(@seller, @buyer).first
    
    mail to: appointment.buyer.email, 
    subject: "Test Drive Request Declined"
  end
  
  def review_request(appointment)
    
    @appointment = appointment
    @buyer       = appointment.buyer.name
    @seller      = appointment.vehicle.user.name
    @vehicle     = appointment.vehicle
    
    mail to: appointment.buyer.email, 
    subject: "Write A Review!"
  end
end