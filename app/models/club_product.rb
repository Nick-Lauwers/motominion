class ClubProduct < ActiveRecord::Base
  
  belongs_to :club
  
  has_many :club_product_photos, dependent: :destroy
  
  validates :price, :description, :club_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  
  # Removes spaces and commas from price and mileage.
  
  def price=(val)
    write_attribute :price, val.to_s.gsub(/[\s,]/, '').to_i
  end
end
