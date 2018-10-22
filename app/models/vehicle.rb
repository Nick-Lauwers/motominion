# complete

class Vehicle < ActiveRecord::Base
  
#  searchkick word_start: [:listing_name, :city], locations: [:location]

  belongs_to :user
  belongs_to :dealership
  belongs_to :vehicle_make
  belongs_to :vehicle_model
  
  has_many :purchases, dependent: :destroy
  
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
  
  has_many :upgrades, dependent: :destroy
  accepts_nested_attributes_for :upgrades, allow_destroy: true
  
  has_many :special_offers, dependent: :destroy
  accepts_nested_attributes_for :special_offers, allow_destroy: true
  
  has_one :listing_score, dependent: :destroy

  # MINIMUM_PHOTOS = 2

  # validate :on => :save do
  #   if self.photos.size < MINIMUM_PHOTOS
  #     errors.add :vehicle, "Must have at least #{MINIMUM_PHOTOS} photos."
  #   end
  # end
  
  # before_save      { vin.upcase! }
  # default_scope -> { order(created_at: :desc) }
  
  # validates :vehicle_make_id, :vehicle_model_id, 
  
  validates :year, presence: true, 
    unless: Proc.new { |vehicle| vehicle.user_id.blank? }
  validates :actual_price, presence: true, 
    unless: Proc.new { |vehicle| vehicle.user_id.blank? }
  validates :mileage_numeric, presence: true, 
    unless: Proc.new { |vehicle| vehicle.user_id.blank? }
  
            # :user_id, :body_style, :color, :transmission, :fuel_type, 
            # :drivetrain, :street_address, :city, :state, :seating_capacity, 
            # presence: true
  # validates :listing_name, presence: true, length: { maximum: 50 }
  # validates :summary,      presence: true
  # , length: { maximum: 600 }
  # validates :sellers_notes,                          length: { maximum: 600 }
  
  # VALID_VIN_REGEX = /[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{3}\d{5}/
  # validates :vin, presence: true, format: { with: VALID_VIN_REGEX }
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  filterrific(
    # default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_vehicle_make_id, 
      :with_vehicle_model_id,
      :with_zip_code,
      :with_distance,
      :near_city,
      :with_cafe_racer,
      :with_cruiser,
      :with_dirt_bike_dual_sport,
      :with_moped_mini,
      :with_sportbike,
      :with_standard,
      :with_touring,
      :with_trike,
      :with_condition,
      :with_dealer,
      :with_year_gte,
      :with_actual_price_lte,
      :with_mileage_numeric_lte,
      :with_engine_size_gte,
      :with_body_style,
      :with_color,
      :with_engine_type,
      :with_fuel_type,
      :with_cruise_control,
      :with_am_fm,
      :with_cb_radio,
      :with_navigation_system,
      :with_heated_seats,
      :with_heated_hand_grips,
      :with_alarm_system,
      :with_saddlebags,
      :with_trunk,
      :with_tow_hitch,
      :with_cycle_cover
    ]
  )
  
  scope :sorted_by, lambda { |sort_option|
    
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    
    case sort_option.to_s
    when /^price_/
      order("vehicles.price #{ direction }")
    when /^created_at_/
      order("vehicles.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
    
  scope :with_vehicle_make_id, lambda { |vehicle_make_id|
    where(vehicle_make_id: vehicle_make_id)
  }
  
  scope :with_vehicle_model_id, lambda { |vehicle_model_id|
    where(vehicle_model_id: vehicle_model_id)
  }
  
  scope :with_zip_code, lambda { |ref_zip_code|
    Vehicle.near(ref_zip_code.to_s.to_region, 20, order: nil)
  }
  
  scope :with_distance, lambda { |distance_attrs|
    if distance_attrs.zip_code.present? && distance_attrs.max_distance.present?
      Vehicle.near(distance_attrs.zip_code.to_s.to_region, distance_attrs.max_distance, order: nil)
    elsif distance_attrs.zip_code.present?
      Vehicle.all
    end
  }
  
  scope :near_city, lambda { |city|
    Vehicle.near(city, 20, order: nil)
  }
  
  scope :with_cafe_racer, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Cafe Racer")
  }
  
  # scope :with_cruiser, lambda { |flag|
  #   return nil if 0 == flag
  #   where(body_style: "Cruiser")
  # }
  
  scope :with_dirt_bike_dual_sport, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Dirt Bike / Dual-Sport")
  }
  
  scope :with_moped_mini, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Moped / Mini")
  }
  
  scope :with_sportbike, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Sportbike")
  }
  
  scope :with_standard, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Standard")
  }
  
  scope :with_touring, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Touring")
  }
  
  scope :with_trike, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Trike")
  }
  
  scope :with_condition, lambda { |ref_condition|
    where('vehicles.condition = ?', ref_condition)
  }
  
  scope :with_dealer, lambda { |ref_dealer|
    if ref_dealer == "Dealer"
      Vehicle.where.not(dealership_id: nil)
    elsif ref_dealer == "Private"
      Vehicle.where(dealership_id: nil)
    end
  }
  
  # scope :with_year_gte, lambda { |ref_year|
  #   Vehicle.where.not(:year.lt(ref_year))
  # }
  
  scope :with_year_gte, lambda { |ref_year|
    where('vehicles.year >= ? OR vehicles.year IS NULL', ref_year)
  }
  
  # scope :with_actual_price_lte, lambda { |ref_price|
  #   Vehicle.
  #     where.not(:actual_price.gt(ref_price)).
  #     where.not(:msrp.gt(ref_price))
  # }
  
  scope :with_actual_price_lte, lambda { |ref_price|
    where('vehicles.actual_price <= ? OR vehicles.actual_price IS NULL', ref_price)
  }
  
  # scope :with_mileage_numeric_lte, lambda { |ref_mileage|
  #   Vehicle.where.not(:mileage_numeric.gt(ref_mileage))
  # }
  
  scope :with_mileage_numeric_lte, lambda { |ref_mileage|
    where('vehicles.mileage_numeric <= ? OR vehicles.mileage_numeric IS NULL', ref_mileage)
  }
  
  # scope :with_engine_size_gte, lambda { |ref_engine_size|
  #   Vehicle.where.not(engine_size.lt(ref_engine_size)
  # }
  
  scope :with_engine_size_gte, lambda { |ref_engine_size|
    where('vehicles.engine_size >= ? OR vehicles.engine_size IS NULL', ref_engine_size)
  }
  
  # scope :with_seating_capacity_gte, lambda { |ref_capacity|
  #   where('vehicles.seating_capacity >= ?', ref_capacity)
  # }
  
  scope :with_body_style, lambda { |body_style|
    joins(:vehicle_model).where('vehicle_models.vehicle_type = ?', body_style)
  }
  
  scope :with_color, lambda { |color|
    where(color: color)
  }
  
  scope :with_fuel_type, lambda { |fuel_type|
    where(fuel_type: fuel_type)
  }
  
  scope :with_engine_type, lambda { |engine_type|
    where(engine_type: engine_type)
  }
  
  scope :with_cruise_control, lambda { |flag|
    return nil if 0 == flag
    where(cruise_control: true)
  }
  
  scope :with_am_fm, lambda { |flag|
    return nil if 0 == flag
    where(am_fm: true)
  }
  
  scope :with_cb_radio, lambda { |flag|
    return nil if 0 == flag
    where(cb_radio: true)
  }
  
  scope :with_navigation_system, lambda { |flag|
    return nil if 0 == flag
    where(navigation_system: true)
  }
  
  scope :with_heated_seats, lambda { |flag|
    return nil if 0 == flag
    where(heated_seats: true)
  }
  
  scope :with_heated_hand_grips, lambda { |flag|
    return nil if 0 == flag
    where(heated_hand_grips: true)
  }
  
  scope :with_alarm_system, lambda { |flag|
    return nil if 0 == flag
    where(alarm_system: true)
  }
  
  scope :with_saddlebags, lambda { |flag|
    return nil if 0 == flag
    where(saddlebags: true)
  }
  
  scope :with_trunk, lambda { |flag|
    return nil if 0 == flag
    where(trunk: true)
  }
  
  scope :with_tow_hitch, lambda { |flag|
    return nil if 0 == flag
    where(tow_hitch: true)
  }
  
  scope :with_cycle_cover, lambda { |flag|
    return nil if 0 == flag
    where(cycle_cover: true)
  }
  
  # Provides sort options
  def self.options_for_sorted_by
    [
      # ['Registration date (newest first)', 'created_at_desc'],
      # ['Registration date (oldest first)', 'created_at_asc'],
      ['Lowest Price', 'price_asc']
    ]
  end
  
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
  
  # Removes spaces and commas from price and mileage.
  
  def price=(val)
    write_attribute :price, val.to_s.gsub(/[\s,]/, '').to_i
  end
  
  def mileage=(val)
    write_attribute :mileage, val.to_s.gsub(/[\s,]/, '').to_i
  end
end

# Vehicle.where(dealership_id: 3).each do |vehicle|
#   vehicle.latitude = 50.041345
#   vehicle.longitude = -113.590972
#   vehicle.street_address = "25 Alberta Rd"
#   vehicle.city = "Claresholm"
#   vehicle.state = "AB"
#   vehicle.save
# end