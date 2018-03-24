class VehicleMakesController < ApplicationController
  
  def index
    @vehicle_makes = VehicleMake.first(6)
  end
  
  def posts
    @vehicle_make = VehicleMake.find(params[:id])
  end
  
  def discussions
    @vehicle_make = VehicleMake.find(params[:id])
  end
end