class FavoriteVehicle < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  validates :user_id, :vehicle_id, presence: true
end
