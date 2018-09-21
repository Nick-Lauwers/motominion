class VehicleSpecificationValue < ActiveRecord::Base
  belongs_to :vehicle_trim
  belongs_to :vehicle_specification
end
