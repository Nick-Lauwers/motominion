class AddStockNumberToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :stock_number, :string
  end
end
