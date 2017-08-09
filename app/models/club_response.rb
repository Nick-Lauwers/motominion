class ClubResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :club_post
end
