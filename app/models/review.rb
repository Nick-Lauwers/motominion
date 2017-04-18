# complete

class Review < ActiveRecord::Base
  
  belongs_to :vehicle
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewed, class_name: 'User'
  
  validates :title, presence: true, length: { maximum: 70 }
  
  validates :comment, :rating, :vehicle_id, presence: true
end