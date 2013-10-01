require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "twitter-bootstrap-rails"
require "bootstrap-sass"
# require 'ruby_apk'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Appdistributor
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.filter_parameters += [:password, :password_confirmation]

    config.middleware.insert 0, 'Rack::Cache', {
          :verbose     => true,
          :metastore   => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"),
          :entitystore => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
        } # unless Rails.env.production?  ## uncomment this 'unless' in Rails 3.1,
                                          ## because it already inserts Rack::Cache in production

    config.middleware.insert_after 'Rack::Cache', 'Dragonfly::Middleware', :images

    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
  end

  end
end
