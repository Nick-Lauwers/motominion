# complete

class Question < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  has_many :answers, dependent: :destroy
  
  # Look at extra code from railscast
  accepts_nested_attributes_for :answers
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :vehicle_id, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end
