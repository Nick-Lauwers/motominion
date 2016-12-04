# complete

class AppointmentsController < ApplicationController
  before_action :logged_in_user

  def create
    
    @appointment = current_user.appointments.build(appointment_params)
    
    if @appointment.save
      AppointmentMailer.appointment_request(@appointment).deliver_now
      flash[:success] = "Appointment saved"
      redirect_to @appointment.vehicle
      
    else
      redirect_to vehicles_path
    end
  end
  
  def destroy
    @appointment.destroy
    flash[:success] = "Appointment deleted"
    redirect_to request.referrer
  end
  
  def test_drives
    @test_drives = current_user.appointments
  end
  
  def customers
    @vehicles = current_user.vehicles
    @customer_count = 0
  end
  
  private
  
    def appointment_params
      params.require(:appointment).permit(:date, :vehicle_id)
    end
end