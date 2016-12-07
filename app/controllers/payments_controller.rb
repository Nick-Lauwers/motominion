class PaymentsController < ApplicationController
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @payment = @vehicle.payment.build
    respond_with(@payment)
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.ip_address = request.remote_ip

    if @payment.save
      if @payment.process
        redirect_to payments_path, notice: "The user has been successfully charged." and return
      end
    end
    render 'new'
  end
  
  private

    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number,
                                      :card_verification_value, 
                                      :card_expiration)
    end
end

# @payment = Payment.new(payment_params)

# if @payment.save
#   # if @payment.process
#   #   redirect_to payments_path, notice: "The user has been successfully charged." and return
#   # end
# else
#   render 'new'
# end

# @vehicle = Vehicle.find_by_id(params[:id])
# @payment = @vehicle.build