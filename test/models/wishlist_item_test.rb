require 'test_helper'

class WishlistItemTest < ActiveSupport::TestCase
  def setup
    @wishlistItem = WishlistItem.new(
                                  vehicle_id:  vehicles(:avalanche).id,
                                  wishlist_id: wishlists(:wishlist_nicholas).id)
  end

  test "should be valid" do
    assert @wishlistItem.valid?
  end

  test "should require a vehicle_id" do
    @wishlistItem.vehicle_id = nil
    assert_not @wishListItem.valid?
  end

  test "should require a wishlist_id" do
    @wishListItem.wishlist_id = nil
    assert_not @wishListItem.valid?
  end
end
