Bugsnag.configure do |config|
  config.api_key = Rails.application.secrets.bugsnag_secret
end
