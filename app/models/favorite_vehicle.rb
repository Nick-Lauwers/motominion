class FavoriteVehicle < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :vehicle_id, presence: true
end