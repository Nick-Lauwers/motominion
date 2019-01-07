class PersonalizedSearch < ActiveRecord::Base
  
  belongs_to :user
  
  validates :user_id, presence: true
  
  validates :zip_code, format: { with: /\A\d{5}\z/ }, allow_blank: true
end