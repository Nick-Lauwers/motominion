# complete

class Answer < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :question
  
  validates :user_id, :question_id, presence: true
  validates :content, presence: true
  # , length: { maximum: 150 }
end