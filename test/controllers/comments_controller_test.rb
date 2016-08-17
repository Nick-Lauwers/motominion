require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @comment = comments(:cost)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { title:   "Lorem ipsum",
                                               content: "Lorem ipsum",
                                               vehicle: vehicles(:avalanche) } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end
end