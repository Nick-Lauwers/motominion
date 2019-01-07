class AddManufacturersToPersonalizedSearches < ActiveRecord::Migration
  def change
    add_column :personalized_searches, :is_aprilia, :boolean
    add_column :personalized_searches, :is_bmw, :boolean
    add_column :personalized_searches, :is_can_am, :boolean
    add_column :personalized_searches, :is_ducati, :boolean
    add_column :personalized_searches, :is_harley_davidson, :boolean
    add_column :personalized_searches, :is_honda, :boolean
    add_column :personalized_searches, :is_indian, :boolean
    add_column :personalized_searches, :is_ktm, :boolean
    add_column :personalized_searches, :is_kawasaki, :boolean
    add_column :personalized_searches, :is_kymco, :boolean
    add_column :personalized_searches, :is_suzuki, :boolean
    add_column :personalized_searches, :is_triumph, :boolean
    add_column :personalized_searches, :is_vespa, :boolean
    add_column :personalized_searches, :is_victory, :boolean
    add_column :personalized_searches, :is_yamaha, :boolean
  end
end
