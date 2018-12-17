class AddUserDetailsToVehicleInquiries < ActiveRecord::Migration
  def change
    add_column :vehicle_inquiries, :email, :string
    add_column :vehicle_inquiries, :first_name, :string
    add_column :vehicle_inquiries, :last_name, :string
  end
end
