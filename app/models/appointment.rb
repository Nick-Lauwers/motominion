# complete

class Appointment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  # Experiment
  belongs_to :conversation
  
  default_scope -> { order(date: :asc) }
  
  validates :status, :date, :user_id, :vehicle_id, :conversation_id, 
            presence: true
end

# ensure that default scope is correct