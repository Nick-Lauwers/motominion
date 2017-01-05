# complete

require 'elasticsearch/model'

class Vehicle < ActiveRecord::Base
  
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # searchkick
  
  belongs_to :user
  
  # has_one :payment
  
  has_many :appointments,      dependent: :destroy
  has_many :reviews,           dependent: :destroy
  has_many :comments,          dependent: :destroy
  has_many :photos,            dependent: :destroy
  has_many :favorite_vehicles, dependent: :destroy
  
  has_many :favorited_by, through: :favorite_vehicles, source: :user
  
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
            :user_id,       presence: true
  validates :listing_name,  presence: true, length: { maximum: 30 }
  validates :summary,       presence: true, length: { maximum: 600 }
  
  validates :sellers_notes, length: { maximum: 600 }
  
  VALID_VIN_REGEX = /[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{3}\d{5}/
  validates :vin, presence: true, format: { with: VALID_VIN_REGEX }
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  # Computes average rating.
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  end
end