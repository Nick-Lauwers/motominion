class AddScrapedIdToSyncedTables < ActiveRecord::Migration
  def change
    add_column :vehicles, :scraped_id, :integer
    add_column :photos, :scraped_id, :integer
    add_column :dealerships, :scraped_id, :integer
  end
end