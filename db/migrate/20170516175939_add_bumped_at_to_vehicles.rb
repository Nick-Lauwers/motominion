class AddBumpedAtToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :bumped_at, :datetime
  end
end
