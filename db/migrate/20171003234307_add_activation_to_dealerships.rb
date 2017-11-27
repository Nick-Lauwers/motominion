class AddActivationToDealerships < ActiveRecord::Migration
  def change
    add_column :dealerships, :activation_digest, :string
    add_column :dealerships, :activated,         :boolean, default: false
    add_column :dealerships, :activated_at,      :datetime
  end
end
