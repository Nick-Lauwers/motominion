class Availability < ActiveRecord::Base
  
  belongs_to :vehicle
  
  validates :day, :start_time, :end_time, presence: true
end