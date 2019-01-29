class CreateTelephoneCalls < ActiveRecord::Migration
  def change
    create_table :telephone_calls do |t|
      t.references :user, index: true
      t.references :vehicle, index: true

      t.timestamps null: false
    end
  end
end
