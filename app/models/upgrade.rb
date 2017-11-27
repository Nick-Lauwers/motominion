class Upgrade < ActiveRecord::Base
  
  belongs_to :vehicle
  
  has_and_belongs_to_many :purchases
  
  # has_many :purchased_upgrades
  # has_many :purchases, through: :purchased_upgrades
  
  validates :duration, :price, presence: true
  validates :title, presence: true
  # , length: { maximum: 70 }
  # validates :description, presence: true
end