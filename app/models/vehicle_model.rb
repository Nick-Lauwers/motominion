class VehicleModel < ActiveRecord::Base
    
  belongs_to :vehicle_make
  
  has_many :vehicles, dependent: :destroy
  
  validates :vehicle_make_id, presence: true
end
