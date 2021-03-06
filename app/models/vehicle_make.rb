class VehicleMake < ActiveRecord::Base
  
  has_many :vehicle_models, dependent: :destroy
  has_many :vehicles,       dependent: :destroy
  has_many :posts,          dependent: :destroy
  has_many :discussions,    dependent: :destroy
  
  default_scope -> { order(name: :asc) }
  
  # Provides select options for the with_vehicle_make_id input
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
  
  def vehicle_models_above_zero
    vehicle_models.joins(:vehicles).group('vehicle_models.id')
  end
end