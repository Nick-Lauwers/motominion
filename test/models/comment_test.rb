require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user    = users(:archer)
    @vehicle = vehicles(:avalanche)
    @comment = @vehicle.comments.build(title:   "Lorem ipsum",
                                       content: "Lorem ipsum",
                                       likes:   5,
                                       user_id: @user.id)
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
  
  test "associated replies should be destroyed" do
    @comment.save
    @comment.replies.create!(content: "Lorem ipsum",
                             likes:   1,
                             user_id: @user.id)
    assert_difference 'Reply.count', -1 do
      @comment.destroy
    end
  end
end