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
  
  def dashboard
  end
  
  def profile
  end
  
  def search
    if params[:search].present? && params[:search].strip != ""
      session[:vehicle_search] = params[:search]
    end
    
    if session[:vehicle_search] && session[:vehicle_search] != ""
      @vehicles_listing_name = 
        Vehicle.where(listing_name: session[:vehicle_search])
    else
      @vehicles_listing_name = Vehicle.all
    end
    
    @search      = @vehicles_listing_name.ransack(params[:q])
    @vehicles    = @search.result.paginate(page: params[:page], per_page: 10)
    
    @hash = Gmaps4rails.build_markers(@vehicles) do |vehicle, marker|
      marker.lat vehicle.latitude
      marker.lng vehicle.longitude
      # marker.infowindow render_to_string(:partial => "my_template", :locals => { :object => vehicle })
      marker.picture({
        url: "/assets/map-marker-red.png",
        width:  32,
        height: 32
      })
      marker.json({ :id => vehicle.id })
    end
    
    # @arrVehicles = @vehicles.to_a
    
    # @users = User.paginate(page: params[:page])
    
    # respond_to :js
    respond_to do |format|
            format.html {}
            format.js {}
        end
  end
end

# https://techbrownbags.wordpress.com/2014/01/17/rails-ajax-search-sort-paginate-with-ransack-kaminari/
# ransack search ajax