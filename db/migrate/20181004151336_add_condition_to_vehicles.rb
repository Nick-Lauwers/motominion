class AddConditionToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :condition, :string
  end
end
