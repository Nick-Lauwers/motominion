class AddFieldsToDealership < ActiveRecord::Migration
  def change
    add_column :dealerships, :description,                :string
    add_column :dealerships, :website,                    :string
    add_column :dealerships, :sales_phone,                :string
    add_column :dealerships, :service_phone,              :string
    add_column :dealerships, :street_address,             :string
    add_column :dealerships, :building,                   :string
    add_column :dealerships, :city,                       :string
    add_column :dealerships, :state,                      :string
    add_column :dealerships, :latitude,                   :float
    add_column :dealerships, :longitude,                  :float
    add_column :dealerships, :last_run_start_at,          :datetime
    add_column :dealerships, :last_run_end_at,            :datetime
    add_column :dealerships, :last_run_total_records,     :integer
    add_column :dealerships, :last_run_new_records,       :integer
    add_column :dealerships, :last_run_duplicate_records, :integer
    add_column :dealerships, :last_run_error_records,     :integer
  end
end
