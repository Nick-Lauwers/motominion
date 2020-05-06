require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:nicholas)
    @post = @user.posts.build(title:   "Lorem ipsum", 
                              content: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "title should be present" do
    @post.title = "   "
    assert_not @post.valid?
  end

  test "title should be at most 70 characters" do
    @post.title = "a" * 71
    assert_not @post.valid?
  end
  
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
  
  test "associated responses should be destroyed" do
    @user.save
    @user.responses.create!(comment: "Lorem ipsum", 
                            post_id: @post.id)
    assert_difference 'Response.count', -1 do
      @user.destroy
    end
  end
end