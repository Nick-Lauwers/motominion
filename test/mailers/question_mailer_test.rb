require 'test_helper'

class QuestionMailerTest < ActionMailer::TestCase
  test "question_received" do
    mail = QuestionMailer.question_received
    assert_equal "Question received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
