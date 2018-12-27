class VehicleInquiry < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  belongs_to :conversation, inverse_of: :appointments, touch: true
  
  before_save :downcase_email, 
    unless: Proc.new { |vehicle_inquiry| vehicle_inquiry.email.blank? }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, 
  #   # presence: true, 
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    unless: Proc.new { |vehicle_inquiry| vehicle_inquiry.email.blank? }
  
  validates :first_name, :last_name, length: { maximum: 25 }
  
  validates :vehicle_id,
            # :user_id
            # :conversation_id, 
            presence: true
  
  private
  
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end