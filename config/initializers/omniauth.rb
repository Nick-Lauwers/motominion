Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    access_type: 'online', name: 'google'
    
  provider :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], 
    ENV['STRIPE_SECRET']
end