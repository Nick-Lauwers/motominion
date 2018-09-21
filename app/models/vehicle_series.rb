class VehicleSeries < ActiveRecord::Base
  belongs_to :vehicle_model
  has_many :vehicle_trims
end
