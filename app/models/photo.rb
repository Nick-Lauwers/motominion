# complete

class Photo < ActiveRecord::Base
  
  belongs_to :vehicle
  
  before_save   :adjust_rotation
  before_update :reprocess_image

  has_attached_file :image
                    # :processors => [:rotator],
                    # :styles => lambda { |a| {
                    #   :thumb => {
                    #     :geometry => '50x50#',
                    #     :rotation => a.instance.rotation,
                    #   },
                    #   :full => {
                    #     :geometry => '640x640>',
                    #     :rotation => a.instance.rotation,
                    #   },
                    # } }
                    

  validates                         :vehicle_id, :image, presence: true 
  validates_attachment_content_type :image,      content_type: /\Aimage\/.*\Z/
  
  protected
 
    def adjust_rotation
      self.rotation = self.rotation.to_i
      self.rotation = self.rotation % 360 if (self.rotation >= 360 || self.rotation <= -360)
    end
   
    def reprocess_image
      self.image.reprocess! if self.rotation_changed?
    end
end