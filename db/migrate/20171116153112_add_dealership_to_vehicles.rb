class AddDealershipToVehicles < ActiveRecord::Migration
  def change
    add_reference :vehicles, :dealership, index: true, foreign_key: true
    add_index     :vehicles, [:dealership_id, :created_at]
  end
end
