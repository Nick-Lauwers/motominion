class StaticPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def search_results
  end
  
  def search
    
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end
    
    # arrResult = Array.new
    
    if session[:loc_search] && session[:loc_search] != ""
      @vehicles_address = Vehicle.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @vehicles_address = Vehicle.where(active: true).all
    end
    
    @search = @vehicles_address.ransack(params[:q])
    @vehicles = @search.result
      
    @arrVehicles = @vehicles.to_a
    
  end
  
  def vehicle_details
  end
end