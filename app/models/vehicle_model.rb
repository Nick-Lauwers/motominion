class VehicleModel < ActiveRecord::Base
    
  belongs_to :vehicle_make
  
  has_many :vehicles, dependent: :destroy
  
  validates :vehicle_make_id, presence: true
  
  default_scope -> { order(name: :asc) }
  
  # Provides select options for the with_vehicle_model_id input
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
  
  def name_with_count
    "#{name} (#{vehicles.count})"
  end
end