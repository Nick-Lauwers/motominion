class Enquiry < ActiveRecord::Base
  
  before_save      { email.downcase! }
  default_scope -> { order(created_at: :desc) }
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }
                                    
  phony_normalize :phone_number, :default_country_code => 'US'
  validates :phone_number, phony_plausible: true
  
  validates :category, :content, presence: true
end