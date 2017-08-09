# completed

class PhotosController < ApplicationController
  
  def create
    
    @vehicle = Vehicle.find(params[:vehicle_id])
    
    if params[:images]
      params[:images].each do |image|
        @vehicle.photos.create(image: image)
      end
    end
      
    @photos = @vehicle.photos
    flash[:success] = "Updates saved."
    redirect_to photos_vehicle_path(@vehicle)
  end
  
  def destroy
    
    @photo = Photo.find(params[:id])
    @vehicle = @photo.vehicle
    
    # Remove photos with AJAX.
    @photo.destroy
    @photos = Photo.where(vehicle_id: @vehicle.id)
    respond_to :js
  end
end

# ensure that user is logged in and that user is correct