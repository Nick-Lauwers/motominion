require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get basics" do
    get :basics
    assert_response :success
  end

  test "should get upgrades" do
    get :upgrades
    assert_response :success
  end

  test "should get billing" do
    get :billing
    assert_response :success
  end

  test "should get employment" do
    get :employment
    assert_response :success
  end

  test "should get financial" do
    get :financial
    assert_response :success
  end

end
