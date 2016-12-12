# complete

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    image_size: 'large'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    access_type: 'online', name: 'google'
end

# http://stackoverflow.com/questions/20719735/omniauth-facebook-sessions-controller-create-action-integration-after-michael-ha
# https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/
# scope: 'email', display: 'popup', info_fields: 'name,email'