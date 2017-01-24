# replace reply

require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  
  def setup
    @user     = users(:nicholas)
    @question = questions(:cost)
    @reply    = @question.replies.build(content: "Lorem ipsum",
                                        likes:   3,
                                        user_id: @user.id)
  end

  test "should be valid" do
    assert @reply.valid?
  end

  test "user id should be present" do
    @reply.user_id = nil
    assert_not @reply.valid?
  end
  
  test "comment id should be present" do
    @reply.comment_id = nil
    assert_not @reply.valid?
  end
  
  test "content should be present" do
    @reply.content = "   "
    assert_not @reply.valid?
  end

  test "content should be at most 150 characters" do
    @reply.content = "a" * 151
    assert_not @reply.valid?
  end
end