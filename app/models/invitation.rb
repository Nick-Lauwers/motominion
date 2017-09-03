class Invitation < ActiveRecord::Base
  
  belongs_to :club
  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  
  # validates :token, :club_id, presence: true
  
  # before_create :create_invitation_token
  # before_save   :check_user_existence
  before_save   { email.downcase! }
  
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true
  # , length:     { maximum: 255 },
  #                                   format:     { with: VALID_EMAIL_REGEX }
                                    
  private
    
    # Creates invitation token.
    # def create_invitation_token
    #   self.token = Digest::SHA1.hexdigest([self.club_id, Time.now, rand].join)
    # end
    
    # Checks if recipient is already a user.
    # def check_user_existence
      
    #   recipient = User.find_by_email(email)
      
    #   if recipient
    #     self.recipient_id = recipient.id
    #   end
    # end
end
