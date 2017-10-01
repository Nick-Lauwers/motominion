# class OmniauthCallbacksController < Devise::OmniauthCallbacksController

#   def stripe_connect
    
#     auth_data = request.env["omniauth.auth"]
#     @user     = current_user
    
#     if @user.persisted?
      
#       @user.merchant_id = auth_data.uid
      
#       @user.save
      
#       if @user.merchant_id.blank?
        
#         account = Stripe::Account.retrieve(current_user.merchant_id)
#         account.payout_schedule.delays_days = 7
#         account.payout_schedule.interval    = 'daily'
        
#         account.save
#         logger.debug "#{account}"
#       end
      
#       sign_in_and_redirect @user, event: :authentication
#       flash[:success] = "Stripe account created and connected" if is_navigational_format?
      
#     else
      
#       session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
      
#       redirect_to dashboard_path
#     end
#   end
# end