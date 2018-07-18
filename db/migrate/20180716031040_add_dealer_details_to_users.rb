class AddDealerDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealer_position, :string
    add_column :users, :industry_experience, :integer
  end
end