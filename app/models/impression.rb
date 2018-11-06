class Impression < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  belongs_to :dealership
  
  validates :impression_type, :count, presence: true
end
