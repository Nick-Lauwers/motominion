# complete

class Appointment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  default_scope -> { order(date: :asc) }
  
  # validates :user_id, :vehicle_id, :date, presence: true
end

# ensure that default scope is correct