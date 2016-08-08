class PhotosController < ApplicationController
  # def create
  # 	@photo = Photo.create(photo_params)
  # 	if @photo.save
  # 	  render json: { message: "success" }, :status => 200
  # 	else
  # 	  #  you need to send an error header, otherwise Dropzone
  #         #  will not interpret the response as an error:
  # 	  render json: { error: @photo.errors.full_messages.join(',')}, :status => 400
  # 	end  		
  # end

  # private
  # def photo_params
  # 	params.require(:photo).permit(:image)
  # end
  
  def destroy
    @photo = Photo.find(params[:id])
    vehicle = @photo.vehicle
    
    # Remove photos with AJAX.
    @photo.destroy
    @photos = Photo.where(vehicle_id: vehicle.id)
    respond_to :js
  end
end