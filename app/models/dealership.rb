class Dealership < ActiveRecord::Base
  
  has_many :users,                dependent: :destroy
  has_many :vehicles,             dependent: :destroy
  has_many :reviews,              dependent: :destroy
  has_many :dealer_invitations,   dependent: :destroy
  
  has_many :business_hours,       dependent: :destroy
  accepts_nested_attributes_for :business_hours
  
  attr_accessor :activation_token
  
  before_save   :downcase_email
  before_create :create_activation_digest
  
  # validates :dealership_name,  presence: true, length: { maximum: 50 }
  
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validates :email, presence: true, length:     { maximum: 255 },
  #                                   format:     { with: VALID_EMAIL_REGEX },
  #                                   uniqueness: { case_sensitive: false },
  #                                   allow_blank: true
                                    
  phony_normalize :sales_phone, :default_country_code => 'US'
  # validates :sales_phone, phony_plausible: true
  
  phony_normalize :service_phone, :default_country_code => 'US'
  # validates :service_phone, phony_plausible: true
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  has_attached_file :logo, styles: { thumb: "200x200#"}, 
    default_url: "https://s3.us-east-2.amazonaws.com/motominion-assets/static-assets/photo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  
  has_attached_file :photo,
    default_url: "https://s3.us-east-2.amazonaws.com/motominion-assets/static-assets/photo.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  
  class << self
    
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    DealershipMailer.dealership_activation(self).deliver_now
  end
  
  # Concatenates address fields
  def address
    
    if building.present?
      [street_address, building, city, state].compact.join(', ')
      
    else
      [street_address, city, state].compact.join(', ')
    end
  end
  
  # Returns true if address has been updated
  def address_changed?
    street_address_changed? or building_changed? or city_changed? or 
    state_changed?
  end
  
  # Computes average rating.
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  end
                                    
  private
  
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase if email
    end
    
    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token   = Dealership.new_token
      self.activation_digest  = Dealership.digest(activation_token)
    end
end