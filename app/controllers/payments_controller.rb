class PaymentsController < ApplicationController
  
  def create
    
    if current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method."
      redirect_to payment_method_path
      
    else
      @payment = current_user.payments.build(payment_params)
      charge(@payment)
    end
  end  
  
#   def new
#     @vehicle = Vehicle.find(params[:vehicle_id])
#     @payment = @vehicle.build_payment
#   end

#   def create
#     @vehicle = Vehicle.find(params[:vehicle_id])
    
#     @payment = @vehicle.build_payment(payment_params)
#     @payment.ip_address = request.remote_ip
    
#     if @payment.save
      
#       if @payment.purchase 
#         render 'success'
#       else
#         render 'failure'
#       end
    
#     else
#       render 'new'
#     end
#   end
  
  private
  
    def charge(payment)
      
      if !payment.vehicle.user.stripe_id.blank?
        customer = Stripe::Customer.retrieve(payment.user.stripe_id)
        charge   = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => payment.vehicle.price * 100,
          :description => payment.vehicle.listing_name,
          :currency    => 'usd',
          :destination => {
            :amount  => payment.vehicle.price * 80,
            :account => payment.vehicle.user.merchant_id
          }
        )
        
        if charge
          payment.update_attribute(:received, true)
          flash[:success] = "Payment received!"
          
        else
          payment.update_attribute(:received, false)
          flash[:alert] = "Payment declined."
        end
      end
      
      rescue Stripe::CardError => e
        payment.update_attribute(:received, false)
        flash[:alert] = e.message
    end

#     def payment_params
#       params.require(:payment).permit(:first_name, :last_name, :card_type, 
#                                       :card_number, :card_verification_value, 
#                                       :card_expiration)
#     end
end