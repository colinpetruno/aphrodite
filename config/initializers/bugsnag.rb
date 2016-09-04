Bugsnag.configure do |config|
  config.api_key = "5064645706772365c1ab89cd8e5a695d"
  config.auto_notify = Rails.env.production?
  config.notify_release_stages = ["production"]
end
