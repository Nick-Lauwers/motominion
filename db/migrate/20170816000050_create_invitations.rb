class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      
      t.string     :email
      t.string     :token
      t.references :sender
      t.references :recipient
      t.references :club, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :invitations, [:club_id,      :created_at]
    add_index :invitations, [:sender_id,    :created_at]
    add_index :invitations, [:recipient_id, :created_at]
    
    add_foreign_key :invitations, :users, column: :sender_id
    add_foreign_key :invitations, :users, column: :recipient_id
  end
end
