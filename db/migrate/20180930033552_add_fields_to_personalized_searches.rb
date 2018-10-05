class AddFieldsToPersonalizedSearches < ActiveRecord::Migration
  def change
    add_column :personalized_searches, :is_one_seat, :boolean
    add_column :personalized_searches, :is_two_seats, :boolean
    add_column :personalized_searches, :is_beginner, :boolean
    add_column :personalized_searches, :is_intermediate, :boolean
    add_column :personalized_searches, :is_advanced, :boolean
  end
end
