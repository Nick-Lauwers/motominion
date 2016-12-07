# include card brand, amount
# are presence validations required

class Payment < ActiveRecord::Base
  
  require "active_merchant/billing/rails"
  
  belongs_to :vehicle
  has_one :payment_status
  
  attr_accessor :card_number
  attr_accessor :card_verification_value

  validates :first_name, :last_name, :card_number, :card_verification_value, 
            :card_expiration, presence: true
            
  validate :valid_card
  
  # private 
  
    def credit_card
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :first_name         => first_name,
        :last_name          => last_name,
        :number             => card_number,
        :verification_value => card_verification_value,
        :month              => card_expiration.month,
        :year               => card_expiration.year,
        :type              => 'visa',
      )
    end
    
    # def valid_card
    #   unless credit_card.valid?
    #     credit_card.errors.full_messages.each do |message|
    #       errors.add_to_base message
    #     end
    #   end
    # end
    
    def valid_card
      if !credit_card.valid?
        errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
        false
      else
        true
      end
    end
    
    def process
      if valid_card
        
        response = GATEWAY.authorize(165 * 100, credit_card)
        
        if response.success?
          
          transaction = GATEWAY.capture(165 * 100, response.authorization)
          
          if !transaction.success?
            errors.add(:base, "The credit card you provided was declined. Please
                              double check your information and try again.") and return
            false
          end
          
          update_columns({authorization_code: transaction.authorization, success: true})
          true
        
        else
          errors.add(:base, "The credit card you provided was declined. 
                            Please double check your information and try again.") and return
          false
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