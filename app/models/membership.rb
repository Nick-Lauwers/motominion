class Membership < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :club
  
  default_scope -> { order(created_at: :desc) }
  
  # validates :user_id, :club_id, presence: true
end