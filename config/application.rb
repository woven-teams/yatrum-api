require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TravelApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.active_job.queue_adapter = :async

    config.action_dispatch.show_exceptions = false # this is the default setting in production

    config.filter_parameters << :password


    # ========================================================================

    config.autoload_paths << Rails.root.join('lib')
    # config.active_job.queue_adapter = :delayed_job
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    Oj.mimic_JSON()

    # (For Devise and Rails Admin) Allow session management
    # Read Blog: http://www.carlosramireziii.com/how-to-add-active-admin-to-a-rails-5-api-application.html
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Flash

    config.action_cable.allowed_request_origins = [ENV['WS_STAGING_ORIGIN'],ENV['WS_PRODUCTION_ORIGIN']]

    # Rack cors code
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :put, :patch]
      end
    end
  end
end
