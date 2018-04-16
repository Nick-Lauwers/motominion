class SpecialOffer < ActiveRecord::Base
  
  belongs_to :vehicle
  
  validates :title, :description, presence: true
end
