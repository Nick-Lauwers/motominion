require 'test_helper'

class AnswerMailerTest < ActionMailer::TestCase
  test "answer_received" do
    mail = AnswerMailer.answer_received
    assert_equal "Answer received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
