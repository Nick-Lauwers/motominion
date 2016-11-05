class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :vehicle
  
  validates :title, presence: true, length: { maximum: 50 }
  
  validates :comment, :star, :vehicle_id, presence: true
end