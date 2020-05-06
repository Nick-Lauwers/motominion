require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @reply = replies(:featureA)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Reply.count' do
      post replies_path, params: { reply: { content: "Lorem ipsum",
                                            comment: comments(:features) } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Reply.count' do
      delete reply_path(@reply)
    end
    assert_redirected_to login_url
  end
end