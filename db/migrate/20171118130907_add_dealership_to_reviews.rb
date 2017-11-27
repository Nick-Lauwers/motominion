class AddDealershipToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :dealership, index: true, foreign_key: true
    add_index     :reviews, [:dealership_id, :created_at]
  end
end
