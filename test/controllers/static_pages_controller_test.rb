require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "Dealership.com"
  end
  
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end
  
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
  
  test "should get search_results" do
    get :search_results
    assert_response :success
    assert_select "title", "Search Results | #{@base_title}"
  end
  
  test "should get vehicle_details" do
    get :vehicle_details
    assert_response :success
    assert_select "title", "Vehicle Details | #{@base_title}"
  end
end