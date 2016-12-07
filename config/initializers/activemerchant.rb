# complete

ActiveMerchant::Billing::Base.mode = :test
::GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
  login:     ENV['AM_USERNAME'],
  password:  ENV['AM_PASSWORD'],
  signature: ENV['AM_SIGNATURE']
)

# change from :test to :production for production
# http://sajinmp.in/posts/integrating-paypal-with-active-merchant