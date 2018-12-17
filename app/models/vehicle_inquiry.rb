class VehicleInquiry < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  belongs_to :conversation, inverse_of: :appointments, touch: true
  
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 255 },
                                    format:     { with: VALID_EMAIL_REGEX }
  
  validates :first_name, :last_name, presence: true, length: { maximum: 25 }
  
  validates :user_id, :vehicle_id, 
            # :conversation_id, 
            presence: true
  
  private
  
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end