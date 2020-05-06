require 'test_helper'

class AutopartPhotosControllerTest < ActionController::TestCase
  test "should get destroy" do
    get :destroy
    assert_response :success
  end
end
