class MessagePhotosController < ApplicationController

  def create
    
    @message_photo = MessagePhoto.new(message_photo_params)
    @message_photo.save

    respond_to do |format|
      format.json { 
        render :json => { 
          url: Refile.attachment_url(@message_photo, :image)
        } 
      }
    end
  end
  
  private
  
    def message_photo_params 
      params.require(:message_photo).permit(:image)
    end
end