Rails.application.config.middleware.use OmniAuth::Builder do
  provider :plangrade, ENV['PLANGRADE_CLIENT_ID'], ENV['PLANGRADE_CLIENT_SECRET']
end