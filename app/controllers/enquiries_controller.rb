class EnquiriesController < ApplicationController
  
  def new
    @enquiry = Enquiry.new
  end
  
  def create
    
    @enquiry = Enquiry.new(enquiry_params)
    
    if @enquiry.save
      flash[:info] = "Message sent!"
      redirect_to root_url
      
    else
      render 'new'
    end
  end
  
  private
  
    def enquiry_params
      params.require(:enquiry).permit(:name, :email, :phone_number, :category, 
                                      :content)
    end
end