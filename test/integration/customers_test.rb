require 'test_helper'

class CustomersTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:nicholas)
  end
  
  test "test drives display" do
    log_in_as(@user)
    get customers_path
    assert_template 'customers'
    assert_select 'title', full_title("Customers")
    assert_select "a[href=?]", vehicles_path
    assert_select "a[href=?]", test_drives_path
    assert_select "a[href=?]", customers_path
  end
end