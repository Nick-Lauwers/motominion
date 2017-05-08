# completed
# destroy - request_referrer

class AppointmentsController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_appointment, only: [:accept, :decline]
  
  # def new
    # @appointment = @vehicle.appointments.build  
  # end
  
  def create
    
    # seller = Vehicle.where(id: params[:appointment][:vehicle_id]).first.user

    # if Conversation.between(current_user.id, seller.id).present?
    #   conversation = Conversation.between(current_user.id, seller.id).first
    # else
    #   conversation = Conversation.create(sender_id:     current_user.id, 
    #                                       recipient_id: seller.id)
    # end
    
    # params[:appointment][:conversation_id] = conversation.id
    
    # @appointment = current_user.appointments.build(appointment_params)
    
    # @vehicle = Vehicle.find(params[:vehicle_id])
    # @appointment = @vehicle.appointments.build(appointment_params).build_conversation
    # # @appointment = @vehicle.appointments.create(appointment_params)
    # @appointment.save

    # if @appointment.save
    #   AppointmentMailer.appointment_request(@appointment).deliver_now
    #   flash[:success] = "Test drive request sent!"
    #   redirect_to @vehicle
    # else
    #   flash[:failure] = "Failed to send test drive request."
    #   redirect_to @vehicle
    # end
  end
  
  def destroy
    @appointment.destroy
    flash[:success] = "Appointment deleted"
    redirect_to request.referrer
  end

  def test_drives
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
    @appointment.conversation.update_attributes(next_contributor_id: :buyer_id, 
                                                latest_message_read: false)
    AppointmentMailer.appointment_accepted(@appointment).deliver_now
    ReviewNotifierJob.set(wait_until: @appointment.date).perform_later(@appointment)
    flash[:success] = "Test drive accepted!"
    redirect_to :back
  end
  
  def decline
    @appointment.update_attribute(:status, 'declined')
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