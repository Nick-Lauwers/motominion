# include card brand, amount
# are presence validations required

class Payment < ActiveRecord::Base
  
  belongs_to :vehicle
  
  has_many :payment_statuses
  
  attr_accessor :card_number
  attr_accessor :card_verification_value
  
  validate :validate_card, :on => :create
  
  # validates :ip_address, :first_name, :last_name, :card_type, :card_expiration, 
  #           :card_number, :card_verification_value, :vehicle_id, presence: true

  def purchase 
    response = GATEWAY.purchase(1000, credit_card, purchase_options)
    # payment_statuses.create!(:action   => 'purchase', 
    #                         :amount   => price_in_cents,
    #                         :response => response)
    # vehicle.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  
  def price_in_cents
    # (payment.vehicle.price*100).round
  end

  private 
  
    def credit_card
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :first_name         => first_name,
        :last_name          => last_name,
        :type               => card_type,
        :number             => card_number,
        :verification_value => card_verification_value,
        :month              => card_expiration.month,
        :year               => card_expiration.year
      )
    end
    
    def validate_card
      unless credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          errors[:base] << message
        end
      end
    end
    
    def purchase_options
      {
        :ip => ip_address,
        :billing_address => {
          :name     => "Ryan Bates",
          :address1 => "123 Main St.",
          :city     => "New York",
          :state    => "NY",
          :country  => "US",
          :zip      => "10001"
        }
      }
    end
end

# http://railscasts.com/episodes/145-integrating-active-merchant?autoplay=true
# https://richonrails.com/articles/credit-card-processing-with-active-merchant