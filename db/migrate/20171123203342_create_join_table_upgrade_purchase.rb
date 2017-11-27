class CreateJoinTableUpgradePurchase < ActiveRecord::Migration
  def change
    create_join_table :upgrades, :purchases do |t|
      # t.index [:upgrade_id, :purchase_id]
      # t.index [:purchase_id, :upgrade_id]
    end
  end
end
