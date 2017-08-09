class AddPostedAtToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :posted_at, :datetime
  end
end
