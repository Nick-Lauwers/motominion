class CreateDealerInvitations < ActiveRecord::Migration
  def change
    
    create_table :dealer_invitations do |t|
      t.string :email
      t.references :sender
      t.references :dealership, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :dealer_invitations, [:dealership_id, :created_at]
    add_index :dealer_invitations, [:sender_id,     :created_at]

    add_foreign_key :dealer_invitations, :users, column: :sender_id
  end
end
