class Appointment < ActiveRecord::Base
  
  belongs_to :vehicle
  belongs_to :conversation, inverse_of: :appointments, touch: true
  belongs_to :buyer,  class_name: 'User', foreign_key: :buyer_id
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id
  
  default_scope -> { order(date: :asc) }
  
  validates :status, :date, :seller_id, :buyer_id, :vehicle_id,
            presence: true
end