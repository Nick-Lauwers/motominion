class Club < ActiveRecord::Base
  
  searchkick 
  # word_start: [:city]
  
  has_many :memberships,   dependent: :destroy
  has_many :invitations,   dependent: :destroy
  has_many :posts,         dependent: :destroy
  has_many :discussions,   dependent: :destroy
  has_many :club_products, dependent: :destroy
  has_many :users,         through:   :memberships
  
  validates :name, :description, :city, :state, presence: true
  
  has_attached_file :cover_photo
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  # Concatenates address fields
  def address
    
    # if apartment.present?
    #   [street_address, apartment, city, state].compact.join(', ')
      
    # else
      # [street_address, ]
      [city, state].compact.join(', ')
    # end
  end
  
  # Returns true if address has been updated
  def address_changed?
    # street_address_changed? or apartment_changed? or 
    city_changed? or state_changed?
  end
end