class AddLocationToPersonalizedSearches < ActiveRecord::Migration
  def change
    add_column :personalized_searches, :zip_code, :string
    add_column :personalized_searches, :max_distance, :integer
  end
end
