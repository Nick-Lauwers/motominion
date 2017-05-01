class VehicleMake < ActiveRecord::Base
  
  has_many :vehicle_models
  has_many :vehicles
end
