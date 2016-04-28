require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,          "Dealership.com"
    assert_equal full_title("Help"),  "Help | Dealership.com"
  end
end