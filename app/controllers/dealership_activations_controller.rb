class DealershipActivationsController < ApplicationController
  
  def edit
    
    dealership = Dealership.find_by(email: params[:email])
    
    if dealership && !dealership.activated? && dealership.authenticated?(:activation, params[:id])
      dealership.activate
      flash[:success] = "Account activated!"
      redirect_to basics_dealership_path(dealership)
      
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end