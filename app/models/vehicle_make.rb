class VehicleMake < ActiveRecord::Base
  
  has_many :vehicle_models, dependent: :destroy
  has_many :vehicles,       dependent: :destroy
  has_many :posts,          dependent: :destroy
  has_many :discussions,    dependent: :destroy
end
