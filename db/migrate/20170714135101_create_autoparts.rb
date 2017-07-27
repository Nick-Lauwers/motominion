class CreateAutoparts < ActiveRecord::Migration
  def change
    create_table :autoparts do |t|
      
      t.string     :listing_name
      t.string     :street_address
      t.string     :apartment
      t.string     :city
      t.string     :state
      t.integer    :price
      t.text       :summary
      t.text       :shipping_info
      t.float      :latitude
      t.float      :longitude
      t.datetime   :bumped_at
      t.datetime   :sold_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :autoparts, [:user_id, :created_at]
  end
end
