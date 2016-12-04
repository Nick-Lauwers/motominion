class Wishlist < ActiveRecord::Base
  belongs_to :user
  
  has_many :wishlistItems, dependent: :destroy
  has_many :vehicles, through: :wishlistItems
end
