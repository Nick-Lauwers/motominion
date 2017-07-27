class FavoriteAutopart < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :autopart
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :autopart_id, presence: true
end