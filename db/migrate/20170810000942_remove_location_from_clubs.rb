class RemoveLocationFromClubs < ActiveRecord::Migration
  def change
    remove_column :clubs, :location, :string
  end
end
