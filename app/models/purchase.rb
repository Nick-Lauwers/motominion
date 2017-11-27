class Purchase < ActiveRecord::Base
  
  belongs_to :vehicle
  belongs_to :buyer,  class_name: 'User'
  belongs_to :seller, class_name: 'User'
  
  has_and_belongs_to_many :upgrades
  
  # has_many :purchased_upgrades
  # has_many :upgrades, through: :purchased_upgrades
  
  before_save :downcase_email
  
  validates :vehicle_id, :buyer_id, :seller_id, :first_name, :last_name, :email, 
    presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 255 },
                                    format:     { with: VALID_EMAIL_REGEX }
                                    # ,
                                    # uniqueness: { case_sensitive: false }
  
  phony_normalize :phone_number, :default_country_code => 'US'
  validates :phone_number, phony_plausible: true
  
  private
  
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end