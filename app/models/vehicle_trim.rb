class VehicleTrim < ActiveRecord::Base
  belongs_to :vehicle_series
  has_many :vehicle_specification_values
end
