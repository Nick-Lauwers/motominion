class RemoveUserFromImpressions < ActiveRecord::Migration
  def change
    remove_foreign_key :impressions, :users
  end
end
