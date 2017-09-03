class AddLocationToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :city,  :string
    add_column :clubs, :state, :string
  end
end
