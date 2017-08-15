class AddMerchantIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :merchant_id, :string
  end
end
