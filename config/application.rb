require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CssManager
  class Application < Rails::Application
    config.active_job.queue_adapter = :resque

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.to_prepare do
      Devise::SessionsController.layout "marketing"
    end

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]

    config.action_mailer.default_url_options = {
      host: "mail.aphroditecss.com",
      protocol: "https"
    }

    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
      api_key: Rails.application.secrets.mailgun_api_secret,
      domain: "mail.aphroditecss.com"
    }
    config.action_mailer.preview_path = Rails.root.join("spec", "mailers", "previews").to_s
  end
end
