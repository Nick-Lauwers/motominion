class BusinessHour < ActiveRecord::Base
  
  belongs_to :dealership
  
  validates :day, :open_time, :close_time, presence: true
end
