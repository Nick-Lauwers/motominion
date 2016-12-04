# complete

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
  
  test "should get how_it_works" do
    get :how_it_works
    assert_response :success
    assert_select "title", "How It Works | #{@base_title}"
  end
  
  test "should get legal" do
    get :legal
    assert_response :success
    assert_select "title", "Legal | #{@base_title}"
  end
end