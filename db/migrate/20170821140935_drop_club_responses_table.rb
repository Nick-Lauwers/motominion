class DropClubResponsesTable < ActiveRecord::Migration
  def up
    drop_table :club_responses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
