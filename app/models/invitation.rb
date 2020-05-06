class Invitation < ActiveRecord::Base
  
  belongs_to :club
  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  before_save   { email.downcase! }
  
  validates :email, presence: true
end
