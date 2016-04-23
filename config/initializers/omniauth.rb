Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, "33410623319.35772666103", "a38cb5b9e6bb7de3021c196329f1cb05", scope: "identify,read,post"
end
