# completed

class PhotosController < ApplicationController
  
  before_action :get_photo, except: [:create]
  
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
    
    @vehicle = @photo.vehicle
    
    # Remove photos with AJAX.
    @photo.destroy
    @photos = Photo.where(vehicle_id: @vehicle.id)
    respond_to :js
  end
  
  def rotate

    @photo.update_attribute(:rotation, -90)
    flash[:notice] = "The image has been rotated"
    redirect_to :back
  end

  private
      
    # Before filters
    
    # Identifies photo id.
    def get_photo
      @photo = Photo.find(params[:id])
    end
end

# ensure that user is logged in and that user is correct