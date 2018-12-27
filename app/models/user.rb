# complete

class User < ActiveRecord::Base
  
  belongs_to :dealership
  
  # Experiment
  
  has_many :initiated_conversations, class_name: 'Conversation', 
    dependent: :destroy, foreign_key: :sender_id
  accepts_nested_attributes_for :initiated_conversations, allow_destroy: true
  
  # has_many :conversations
  # accepts_nested_attributes_for :conversations, allow_destroy: true
  
  # has_many :appointments,      dependent: :destroy
  # has_many :inquiries,         dependent: :destroy
  
  # has_one :profile,            dependent: :destroy
  
  has_many :impressions
  
  has_many :vehicles,            dependent: :destroy
  has_many :autoparts,           dependent: :destroy
  has_many :discussions,         dependent: :destroy
  has_many :discussion_comments, dependent: :destroy
  has_many :posts,               dependent: :destroy
  has_many :post_comments,       dependent: :destroy
  has_many :blogs,               dependent: :destroy
  has_many :favorite_vehicles,   dependent: :destroy
  has_many :favorite_autoparts,  dependent: :destroy
  has_many :memberships,         dependent: :destroy
  has_many :vehicle_inquiries,   dependent: :destroy
  
  has_one :personalized_search,  dependent: :destroy
  
  has_many :authored_reviews, class_name: 'Review', dependent: :destroy,
    foreign_key: :reviewer_id
  has_many :received_reviews, class_name: 'Review', dependent: :destroy, 
    foreign_key: :reviewed_id
    
  has_many :sent_invitations, class_name: 'Invitation', dependent: :destroy,
    foreign_key: :sender_id
  has_many :received_invitations, class_name: 'Invitation', dependent: :destroy, 
    foreign_key: :recipient_id
    
  has_many :purchases_made, class_name: 'Purchase', dependent: :destroy,
    foreign_key: :buyer_id
  has_many :purchases_received, class_name: 'Purchase', dependent: :destroy, 
    foreign_key: :seller_id
    
  has_many :sent_dealer_invitations, class_name: 'DealerInvitation', 
    dependent: :destroy, foreign_key: :sender_id
    
  has_many :favorites, through: :favorite_vehicles,  source: :vehicle
  # has_many :favorites, through: :favorite_autoparts, source: :autopart
  has_many :clubs, through: :memberships
  
  attr_accessor :remember_token, :activation_token, :reset_token
  
  acts_as_voter
  
  before_save   :downcase_email
  # before_update :create_activation_digest, if: :create_activation_digest_changed?
  # before_create :create_activation_digest, unless: :dealership_admin
  
  # after_create  :create_profile
  
  validates :first_name, :last_name,  
    # presence: true, 
    length: { maximum: 25 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 255 },
                                    format:     { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
                                    
  has_secure_password validations: false
  validates :password, presence:     true, 
                       confirmation: true, 
                       length:       { minimum: 6, maximum: 72 }, 
                       allow_nil:    true

  validates :residence, :school, :work, length: { maximum: 70 }
  
  phony_normalize :phone_number, :default_country_code => 'US'
  validates :phone_number, phony_plausible: true
  
  has_attached_file :avatar, styles: { thumb: "200x200#"},
    default_url: "https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
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
  
  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    update_attribute(:activation_digest, User.digest(activation_token))
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end
  
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # Saves user using social authentication
  def self.from_omniauth(auth)
    where(provider: auth.provider, 
          uid:      auth.uid).first_or_initialize.tap do |user|
      user.provider      = auth.provider
      user.uid           = auth.uid
      user.first_name    = auth.info.first_name unless user.first_name != nil
      user.last_name     = auth.info.last_name unless user.last_name != nil
      user.email         = auth.info.email unless user.email != nil
      # user.email         = SecureRandom.hex + '@example.com' unless 
      #                     user.email != nil
      user.password      = SecureRandom.urlsafe_base64 unless 
                           user.password != nil
      user.activated     = true
      user.is_subscribed = false unless user.is_subscribed == true
      user.avatar        = URI.parse(auth.info.image) unless 
                           auth.info.image !=nil
      user.save!
    end
  end
  
  # Computes average rating.
  def average_rating
    received_reviews.count == 0 ? 0 : received_reviews.average(:rating).round(2)
  end
  
  # Checks if user is online.
  def online?
    updated_at > 10.minutes.ago
  end
  
  # Concatenates first and last names.
  def full_name
    "#{first_name} #{last_name}"
  end
  
  private
  
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    
    # Creates and assigns the activation token and digest.
    # def create_activation_digest
    #   self.activation_token   = User.new_token
    #   self.activation_digest  = User.digest(activation_token)
    # end
end

# eliminate / revise omniauth email
# all has_many's on one line