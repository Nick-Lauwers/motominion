require 'test_helper'

class ReplyMailerTest < ActionMailer::TestCase
  test "reply_received" do
    mail = ReplyMailer.reply_received
    assert_equal "Reply received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
