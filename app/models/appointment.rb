# complete

class Appointment < ActiveRecord::Base
  
  belongs_to :vehicle
  belongs_to :conversation, inverse_of: :appointments, touch: true
  belongs_to :buyer,  class_name: 'User', foreign_key: :buyer_id
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id
  
  default_scope -> { order(date: :asc) }
  
  validates :status, :date, :seller_id, :buyer_id, :vehicle_id, 
            # :conversation_id,
            presence: true
  
  # validate :date_must_be_in_the_future
  
  # # Returns false if an appointment is scheduled for the past
  # def date_must_be_in_the_future
  #   if date.present? && date <= Time.now
  #     errors.add(:date, "must be in the future")
  #   end
  # end
end

# ensure that default scope is correct