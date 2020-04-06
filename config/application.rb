require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Evally
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |generate|
      generate.helper false
      generate.template_engine false
      generate.javascripts false
      generate.system_tests false
      generate.factory_bot suffix: 'factory'
    end

    config.env = Rails.application.config_for(:env)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.eager_load_paths << Rails.root.join('app', 'forms')
    config.eager_load_paths << Rails.root.join('app', 'policies')
    config.eager_load_paths << Rails.root.join('app', 'presenters')
    config.eager_load_paths << Rails.root.join('app', 'queries')
    config.eager_load_paths << Rails.root.join('app', 'serializers')
    config.eager_load_paths << Rails.root.join('app', 'services')

    # Whitelist locales available for the application
    config.i18n.available_locales = %i[en pl]

    # Set default locale to something other than :en
    config.i18n.default_locale = :en

    # Set i18n fallbacks
    config.i18n.fallbacks = true

    # Action mailer settings
    config.action_mailer.asset_host = config.env.fetch(:core).fetch(:mailer_host)
    config.action_mailer.default_url_options = { host: config.env.fetch(:core).fetch(:mailer_host) }
  end
end
