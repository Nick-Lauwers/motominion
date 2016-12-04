require 'test_helper'

class EnquiryTest < ActiveSupport::TestCase
  
  def setup
    @enquiry = Enquiry.new(name:         "Example User", 
                           email:        "user@example.com",
                           phone_number: "+18005555555", 
                           category:     "List your vehicle",
                           content:      "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @enquiry.valid?
  end
  
  test "name should be present" do
    @enquiry.name = "      "
    assert_not @enquiry.valid?
  end
  
  test "email should be present" do
    @enquiry.email = "     "
    assert_not @enquiry.valid?
  end
  
  test "category should be present" do
    @enquiry.category = "      "
    assert_not @enquiry.valid?
  end
  
  test "content should be present" do
    @enquiry.content = "     "
    assert_not @enquiry.valid?
  end
  
  test "name should not be too long" do
    @enquiry.name = "a" * 51
    assert_not @enquiry.valid?
  end
  
  test "email should not be too long" do
    @enquiry.email = "a" * 244 + "@example.com"
    assert_not @enquiry.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @enquiry.email = valid_address
      assert @enquiry.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @enquiry.email = invalid_address
      assert_not @enquiry.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @enquiry.email = mixed_case_email
    @enquiry.save
    assert_equal mixed_case_email.downcase, @enquiry.reload.email
  end
  
  test "order should be most recent first" do
    assert_equal enquiries(:most_recent), Enquiry.first
  end
end