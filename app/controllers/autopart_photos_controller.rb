class AutopartPhotosController < ApplicationController
  
  def destroy
    
    @autopart_photo = AutopartPhoto.find(params[:id])
    autopart = @autopart_photo.autopart
    
    # Remove photos with AJAX.
    @autopart_photo.destroy
    @autopart_photos = AutopartPhoto.where(autopart_id: autopart.id)
    respond_to :js
  end
end
