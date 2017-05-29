# complete

class Vehicle < ActiveRecord::Base
  
  searchkick word_start: [:listing_name, :city], locations: [:location]

  belongs_to :user
  belongs_to :vehicle_make
  belongs_to :vehicle_model
  
  # has_one :payment
  
  has_many :reviews,           dependent: :destroy
  has_many :questions,         dependent: :destroy
  has_many :photos,            dependent: :destroy
  has_many :favorite_vehicles, dependent: :destroy
  
  has_many :appointments, dependent: :destroy
  has_many :conversations, through: :appointments
  # has_many :conversations, through: :inquiries
  has_many :favorited_by,  through: :favorite_vehicles, source: :user
  
  has_many :availabilities, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true

  MINIMUM_PHOTOS = 2

  validate :on => :save do
    if self.photos.size < MINIMUM_PHOTOS
      errors.add :vehicle, "Must have at least #{MINIMUM_PHOTOS} photos."
    end
  end
  
  # before_save      { vin.upcase! }
  # default_scope -> { order(created_at: :desc) }
  
  validates :body_style, :color, :transmission, :fuel_type, :drivetrain, 
            :street_address, :city, :state, :year, :price, :mileage, 
            :seating_capacity, :user_id, :vehicle_make_id, :vehicle_model_id,
            presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  validates :summary,      presence: true
  # , length: { maximum: 600 }
  # validates :sellers_notes,                          length: { maximum: 600 }
  
  VALID_VIN_REGEX = /[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{3}\d{5}/
  # validates :vin, presence: true, format: { with: VALID_VIN_REGEX }
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  # Concatenates address fields
  def address
    
    if apartment.present?
      [street_address, apartment, city, state].compact.join(', ')
      
    else
      [street_address, city, state].compact.join(', ')
    end
  end
  
  # Returns true if address has been updated
  def address_changed?
    street_address_changed? or apartment_changed? or city_changed? or 
    state_changed?
  end
  
  # Adds location and user association to search
  def search_data
	  attributes.merge(
	    # user_name: user(&:name),
	    location: { lat: latitude, lon: longitude }
    )
  end
  
  # Computes average rating.
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  end
end