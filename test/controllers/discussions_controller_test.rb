require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  
  def setup
    @post = posts(:improvement)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post :create, post: { title: "Lorem ipsum", 
                            content: "Lorem ipsum" }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end