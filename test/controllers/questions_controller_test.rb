require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @question = questions(:cost)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Question.count' do
      post questions_path, params: { question: { title:   "Lorem ipsum",
                                                 content: "Lorem ipsum",
                                                 vehicle: vehicles(:avalanche) } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Question.count' do
      delete question_path(@question)
    end
    assert_redirected_to login_url
  end
end