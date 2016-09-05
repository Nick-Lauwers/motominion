# change redirect_to location

class EnquiriesController < ApplicationController

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      flash[:success] = "Message sent!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  private

    def enquiry_params
      params.require(:enquiry).permit(:name, :email, :phone_number, :category, 
                                      :content)
    end
end