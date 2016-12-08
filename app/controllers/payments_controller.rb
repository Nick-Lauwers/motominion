class PaymentsController < ApplicationController
  
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @payment = @vehicle.build_payment
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    
    @payment = @vehicle.build_payment(payment_params)
    @payment.ip_address = request.remote_ip
    
    if @payment.save
      
      if @payment.purchase 
        render 'success'
      else
        render 'failure'
      end
    
    else
      render 'new'
    end
  end
  
  private

    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_type, 
                                      :card_number, :card_verification_value, 
                                      :card_expiration)
    end
end