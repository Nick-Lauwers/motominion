# complete

class DiscussionComment < ActiveRecord::Base
  
  belongs_to :discussion
  belongs_to :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :discussion_id, :comment, presence: true
end
