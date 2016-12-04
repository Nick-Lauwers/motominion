# complete

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    image_size: 'large'
end

# http://stackoverflow.com/questions/20719735/omniauth-facebook-sessions-controller-create-action-integration-after-michael-ha
# scope: 'email', display: 'popup', info_fields: 'name,email'