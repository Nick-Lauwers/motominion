# return to listing 13.20 of rails tutorial

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user    = users(:nicholas)
    @vehicle = vehicles(:avalanche)
    @comment = @user.comments.build(title:      "Lorem ipsum",
                                    content:    "Lorem ipsum",
                                    vehicle_id: @vehicle.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "vehicle id should be present" do
    @comment.vehicle_id = nil
    assert_not @comment.valid?
  end
  
  test "title should be present" do
    @comment.title = "   "
    assert_not @comment.valid?
  end

  test "title should be at most 20 characters" do
    @comment.title = "a" * 21
    assert_not @comment.valid?
  end
  
  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "content should be at most 150 characters" do
    @comment.content = "a" * 151
    assert_not @comment.valid?
  end
  
  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end