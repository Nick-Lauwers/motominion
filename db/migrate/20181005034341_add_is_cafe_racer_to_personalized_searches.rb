class AddIsCafeRacerToPersonalizedSearches < ActiveRecord::Migration
  def change
    add_column :personalized_searches, :is_cafe_racer, :boolean
  end
end
