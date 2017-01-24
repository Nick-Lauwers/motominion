# complete

class Question < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  has_many :replies, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :vehicle_id, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end
