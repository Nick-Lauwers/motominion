class VehicleMakesController < ApplicationController
  
  def posts
    @vehicle_make = VehicleMake.find(params[:id])
  end
  
  def discussions
    @vehicle_make = VehicleMake.find(params[:id])
  end
end