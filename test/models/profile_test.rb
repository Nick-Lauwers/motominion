require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def setup
    @user = users(:nicholas)
    @profile = @user.build_profile(description: "Lorem ipsum")
  end

  test "should be valid" do
    assert @profile.valid?
  end

  test "user id should be present" do
    @profile.user_id = nil
    assert_not @profile.valid?
  end
  
  test "residence should be at most 30 characters" do
    @profile.residence = "a" * 31
    assert_not @profile.valid?
  end
  
  test "school should be at most 30 characters" do
    @profile.school = "a" * 31
    assert_not @profile.valid?
  end
  
  test "work should be at most 30 characters" do
    @profile.work = "a" * 31
    assert_not @profile.valid?
  end
end