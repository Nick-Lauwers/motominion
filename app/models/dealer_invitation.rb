class DealerInvitation < ActiveRecord::Base
  
  belongs_to :dealership
  belongs_to :sender, class_name: 'User'
  
  before_save   { email.downcase! }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 255 },
                                    format:     { with: VALID_EMAIL_REGEX }
end
