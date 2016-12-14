class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :residence,    :string
    add_column :users, :school,       :string
    add_column :users, :work,         :string
    add_column :users, :description,  :text
  end
end
