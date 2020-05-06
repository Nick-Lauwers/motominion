require 'test_helper'

class ReviewMailerTest < ActionMailer::TestCase
  test "review_received" do
    mail = ReviewMailer.review_received
    assert_equal "Review received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
