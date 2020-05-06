require 'test_helper'

class DiscussionCommentTest < ActiveSupport::TestCase
  
  def setup
    @user     = users(:archer)
    @post     = posts(:improvement)
    @response = @user.responses.build(comment: "Lorem ipsum", 
                                      post_id: @post.id)
  end
  
  test "should be valid" do
    assert @response.valid?
  end
  
  test "user id should be present" do
    @response.user_id = nil
    assert_not @response.valid?
  end
  
  test "post id should be present" do
    @response.post_id = nil
    assert_not @response.valid?
  end
  
  test "comment should be present" do
    @response.comment = "   "
    assert_not @response.valid?
  end
  
  test "order should be most recent first" do
    assert_equal responses(:most_recent), Response.first
  end
end
