require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  
  def setup
    @user     = users(:archer)
    @vehicle  = vehicles(:avalanche)
    @question = @vehicle.comments.build(title:   "Lorem ipsum",
                                        content: "Lorem ipsum",
                                        likes:   5,
                                        user_id: @user.id)
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "user id should be present" do
    @question.user_id = nil
    assert_not @question.valid?
  end
  
  test "vehicle id should be present" do
    @question.vehicle_id = nil
    assert_not @question.valid?
  end
  
  test "title should be present" do
    @question.title = "   "
    assert_not @question.valid?
  end

  test "title should be at most 20 characters" do
    @question.title = "a" * 21
    assert_not @question.valid?
  end
  
  test "content should be present" do
    @question.content = "   "
    assert_not @question.valid?
  end

  test "content should be at most 150 characters" do
    @question.content = "a" * 151
    assert_not @question.valid?
  end
  
  test "order should be most recent first" do
    assert_equal questions(:most_recent), Question.first
  end
  
  test "associated replies should be destroyed" do
    @question.save
    @question.replies.create!(content: "Lorem ipsum",
                              likes:   1,
                              user_id: @user.id)
    assert_difference 'Reply.count', -1 do
      @question.destroy
    end
  end
end