require 'test_helper'

class WishlistTest < ActiveSupport::TestCase
  def setup
    @user = users(:nicholas)
  end
  
  test "associated wishlist should be destroyed" do
    @user.save
    @user.wishlist.create!()
    assert_difference 'Wishlist.count', -1 do
      @user.destroy
    end
  end
end
