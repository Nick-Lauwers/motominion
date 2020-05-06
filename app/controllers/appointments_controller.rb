class AppointmentsController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_appointment, only: [:accept, :decline]
  
  def create
  end
  
  def destroy
    @appointment.destroy
    flash[:success] = "Appointment deleted"
    redirect_to request.referrer
  end

  def test_drives
    
    @purchases = Purchase.where(buyer_id: current_user.id)
    
    @test_drives = Appointment.where("buyer_id = ? AND date >= ?", 
                                     current_user.id, 
                                     Time.now)
  end
  
  def customers
    @customers = Appointment.where("seller_id = ? AND date >= ?",
                                   current_user.id,
                                   Time.now)
  end
  
  def accept
    
    @appointment.update_attribute(:status, 'accepted')
    
    @appointment.conversation.messages.create!(
      user:    current_user, 
      content: "How are you, " + 
               @appointment.buyer.first_name + 
               "? We would love to have you test drive our listing, " +
               @appointment.vehicle.listing_name +
               ". Please show up at least ten minutes before your scheduled 
               appointment, which will be " +
               @appointment.date.strftime("%A, %d %b") + ", at " + 
               @appointment.date.strftime("%-l:%M%p") + 
               ". Looking forward to seeing you, " +
               @appointment.buyer.first_name + 
               "!"
    )
        
    @appointment.conversation.update_attributes(next_contributor_id: :buyer_id, 
                                                latest_message_read: false)
    AppointmentMailer.appointment_accepted(@appointment).deliver_now
    ReviewNotifierJob.set(wait_until: @appointment.date).perform_later(@appointment.id)
    flash[:success] = "Test drive accepted!"
    redirect_to :back
  end
  
  def decline
    
    @appointment.update_attribute(:status, 'declined')
    
    @appointment.conversation.messages.create!(
      user:    current_user, 
      content: "Hi, " + 
               @appointment.buyer.first_name + 
               "! Unfortunately, we are unable to schedule you for a test drive
               of our listing, " +
               @appointment.vehicle.listing_name +
               ". We aren't available at your requested time, " +
               @appointment.date.strftime("%A, %d %b") + ", at " + 
               @appointment.date.strftime("%-l:%M%p") + 
               ". If there is another time that works well for you, please 
               message us with the details. Looking forward to hearing from 
               you, " +
               @appointment.buyer.first_name + 
               "!"
    )
    
    @appointment.conversation.update_attributes(next_contributor_id: :buyer_id, 
                                                latest_message_read: false)
    AppointmentMailer.appointment_declined(@appointment).deliver_now
    flash[:failure] = "Test drive declined."
    redirect_to :back
  end
  
  private
  
    def appointment_params
      params.require(:appointment).permit(:status, :date, :seller_id, :buyer_id, 
                                          :vehicle_id, :conversation_id)
    end
    
    # Before filters
    
    # Identifies appointment id.
    def get_appointment
      @appointment = Appointment.find(params[:id])
    end
end