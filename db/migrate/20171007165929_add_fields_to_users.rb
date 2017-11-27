class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealership_id,    :integer
    add_column :users, :dealership_admin, :boolean, default: false
  end
end
