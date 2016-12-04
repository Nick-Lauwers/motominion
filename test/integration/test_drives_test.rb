# complete

require 'test_helper'

class TestDrivesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:archer)
  end
  
  test "test drives display" do
    log_in_as(@user)
    get test_drives_path
    assert_template 'test_drives'
    assert_select 'title', full_title("Test Drives")
    assert_select "a[href=?]", vehicles_path
    assert_select "a[href=?]", test_drives_path
    assert_select "a[href=?]", customers_path
  end
end