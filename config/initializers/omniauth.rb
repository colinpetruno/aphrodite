Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
    Rails.application.secrets.slack_client_id,
    Rails.application.secrets.slack_client_secret,
    scope: "identify,read,post"
end
