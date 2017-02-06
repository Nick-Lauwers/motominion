# completed

class PhotosController < ApplicationController
  
  def destroy
    
    @photo = Photo.find(params[:id])
    vehicle = @photo.vehicle
    
    # Remove photos with AJAX.
    @photo.destroy
    @photos = Photo.where(vehicle_id: vehicle.id)
    respond_to :js
  end
end

# ensure that user is logged in and that user is correct