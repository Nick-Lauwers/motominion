# complete

class Post < ActiveRecord::Base
  
  searchkick word_start: [:title]
  
  belongs_to :user
  
  has_many :responses, dependent: :destroy
  
  acts_as_votable
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :content, presence: true
  validates :title, presence: true, length: { maximum: 70 }
end