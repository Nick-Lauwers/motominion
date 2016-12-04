class WishlistItem < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :wishlist
  
  validates :vehicle_id,  presence: true
  validates :wishlist_id, presence: true
end