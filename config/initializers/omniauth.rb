Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
    (ENV["SLACK_CLIENT_ID"] || Rails.application.secrets.slack_client_id),
    Rails.application.secrets.slack_client_secret,
    scope: "identify,read,post"
end
