require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user    = User.new(name:                  "Example User", 
                        email:                 "user@example.com",
                        password:              "foobar", 
                        password_confirmation: "foobar",
                        is_subscribed:         false)
    @vehicle = vehicles(:avalanche)
    @post    = posts(:improvement)
    @comment = comments(:cost)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated profile should be destroyed" do
    @user.save
    assert_difference 'Profile.count', -1 do
      @user.destroy
    end
  end
  
  test "associated wishlist should be destroyed" do
    @user.save
    @user.wishlist.create!
    assert_difference 'Wishlist.count', -1 do
      @user.destroy
    end
  end
  
  test "associated vehicles should be destroyed" do
    @user.save
    @user.vehicles.create!(vehicle_condition:           "New",
                           body_style:                  "Mini-Van", 
                           color:                       "Black",
                           transmission:                "Automatic",
                           fuel_type:                   "Gasoline",
                           drivetrain:                  "Front-Wheel Drive",
                           vin:                         "2C4RDGEG6ER337702", 
                           listing_name:                "Dodge Grand Caravan",
                           address:                     "253 Hudson Crescent, 
                                                         Wallaceburg ON",
                           year:                        2014,
                           price:                       19000,
                           mileage:                     27000,
                           seating_capacity:            7, 
                           summary:                     "Priced right and full 
                                                         of handy features.",
                           sellers_notes:               "Must sell vehicle 
                                                         immediately.",
                           is_leather_seats:            false,
                           is_sunroof:                  false,
                           is_navigation_system:        true,
                           is_dvd_entertainment_system: false,
                           is_bluetooth:                true,
                           is_backup_camera:            true,
                           is_remote_start:             true,
                           is_tow_package:              false,
                           is_autonomy:                 false)
    assert_difference 'Vehicle.count', -1 do
      @user.destroy
    end
  end
  
  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(title:   "Lorem ipsum",
                        content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end
  
  test "associated responses should be destroyed" do
    @user.save
    @user.responses.create!(comment: "Lorem ipsum", 
                            post_id: @post.id)
    assert_difference 'Response.count', -1 do
      @user.destroy
    end
  end
  
  test "associated comments should be destroyed" do
    @user.save
    @user.comments.create!(title:      "Lorem ipsum",
                           content:    "Lorem ipsum",
                           likes:      1,
                           vehicle_id: @vehicle.id)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end
  
  test "associated replies should be destroyed" do
    @user.save
    @user.replies.create!(content:    "Lorem ipsum",
                          likes:      1,
                          comment_id: @comment.id)
    assert_difference 'Reply.count', -1 do
      @user.destroy
    end
  end
end