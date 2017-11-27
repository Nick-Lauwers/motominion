class AddFieldsToDealership < ActiveRecord::Migration
  def change
    add_column :dealerships, :description,    :string
    add_column :dealerships, :website,        :string
    add_column :dealerships, :sales_phone,    :string
    add_column :dealerships, :service_phone,  :string
    add_column :dealerships, :street_address, :string
    add_column :dealerships, :building,       :string
    add_column :dealerships, :city,           :string
    add_column :dealerships, :state,          :string
    add_column :dealerships, :latitude,       :float
    add_column :dealerships, :longitude,      :float
  end
end
