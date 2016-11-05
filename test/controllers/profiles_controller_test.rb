require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  
  def setup
    @profile    = profiles(:nicholas_profile)
    @user       = users(:nicholas)
    @other_user = users(:archer)
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @profile
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    get :update, id: @profile
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @profile
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @profile, profile: { description: "Update", user: @user}
    assert flash.empty?
    assert_redirected_to root_url
  end
end