class AddSoldAtToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :sold_at, :datetime
  end
end
