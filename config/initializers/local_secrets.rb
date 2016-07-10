yaml = "#{Rails.root}/config/secrets.local.yml"

if File.exist?(yaml)
  require "erb"

  all_secrets = YAML.load(ERB.new(IO.read(yaml)).result) || {}
  shared_secrets = all_secrets['shared']
  env_secrets = all_secrets[Rails.env]

  if shared_secrets
    Rails.application.secrets.merge!(shared_secrets.symbolize_keys)
  end

  if env_secrets
    Rails.application.secrets.merge!(env_secrets.symbolize_keys)
  end
end
