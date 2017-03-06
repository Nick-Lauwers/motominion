# complete

class Vehicle < ActiveRecord::Base
  
  searchkick
  
  belongs_to :user

  # has_one :payment
  
  has_many :reviews,           dependent: :destroy
  has_many :questions,         dependent: :destroy
  has_many :photos,            dependent: :destroy
  has_many :favorite_vehicles, dependent: :destroy
  
  has_many :appointments, dependent: :destroy
  has_many :conversations, through: :appointments
  # has_many :conversations, through: :inquiries
  has_many :favorited_by,  through: :favorite_vehicles, source: :user

  MINIMUM_PHOTOS = 2

  validate :on => :save do
    if self.photos.size < MINIMUM_PHOTOS
      errors.add :vehicle, "Must have at least #{MINIMUM_PHOTOS} photos."
    end
  end
  
  before_save      { vin.upcase! }
  default_scope -> { order(created_at: :desc) }
  
  validates :vehicle_condition, :body_style, :color, :transmission, :fuel_type, 
            :drivetrain, :address, :year, :price, :mileage, :seating_capacity,
            :user_id,                presence: true
  validates :listing_name,           presence: true, length: { maximum: 30 }
  validates :summary,                presence: true, length: { maximum: 600 }
  validates :monday_availability,    presence: true, length: { maximum: 30 }
  validates :tuesday_availability,   presence: true, length: { maximum: 30 }
  validates :wednesday_availability, presence: true, length: { maximum: 30 }
  validates :thursday_availability,  presence: true, length: { maximum: 30 }
  validates :friday_availability,    presence: true, length: { maximum: 30 }
  validates :saturday_availability,  presence: true, length: { maximum: 30 }
  validates :sunday_availability,    presence: true, length: { maximum: 30 }
  validates :sellers_notes,                          length: { maximum: 600 }
  
  VALID_VIN_REGEX = /[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{3}\d{5}/
  validates :vin, presence: true, format: { with: VALID_VIN_REGEX }
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  # Adds user association to search
  def search_data
    attributes.merge(
      user_name: user(&:name)
    )
  end
  
  # Computes average rating.
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  end
end