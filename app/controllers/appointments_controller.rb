# completed
# destroy - request_referrer

class AppointmentsController < ApplicationController
  
  before_action :logged_in_user
  
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
  
  private
  
    def appointment_params
      params.require(:appointment).permit(:status, :date, :seller_id, :buyer_id, 
                                          :vehicle_id, :conversation_id)
    end
end