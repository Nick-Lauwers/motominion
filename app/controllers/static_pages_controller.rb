# should contact be under static_pages?

class StaticPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
    @enquiry = Enquiry.new
  end
  
  def how_it_works
  end
  
  def legal
  end
end