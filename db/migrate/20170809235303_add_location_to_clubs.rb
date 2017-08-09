class AddLocationToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :location, :string
  end
end
