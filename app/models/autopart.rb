class Autopart < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :autopart_photos, dependent: :destroy
  
  validates :price, :summary, :street_address, :city, :state, presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  
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
  
  # Removes spaces and commas from price and mileage.
  def price=(val)
    write_attribute :price, val.to_s.gsub(/[\s,]/, '').to_i
  end
end
