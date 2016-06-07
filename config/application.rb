require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Require awesome_print from within rails console
if defined?(IRB)
  require 'awesome_print'
end

module Bloomfire
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += Dir[Rails.root.join('lib/**/')]

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = false

    config.sequel.schema_format = :sql
    config.sequel.schema_dump = true

    Sequel::Database.extension :error_sql
    Sequel::Database.extension :pg_array
    Sequel::Database.extension :pg_enum
    Sequel.extension :blank
    Sequel.extension :core_extensions
    Sequel.extension :pg_array_ops

    config.sequel.after_connect = -> do
      Sequel::Model.plugin :association_proxies
      Sequel::Model.plugin :auto_validations, not_null: :presence
      Sequel::Model.plugin :boolean_readers
      Sequel::Model.plugin :boolean_subsets
      Sequel::Model.plugin :dataset_associations
      Sequel::Model.plugin :dirty
      Sequel::Model.plugin :force_encoding, 'UTF-8'
      Sequel::Model.plugin :inverted_subsets
      Sequel::Model.plugin :json_serializer
      Sequel::Model.plugin :pg_array_associations
      Sequel::Model.plugin :subset_conditions
      Sequel::Model.plugin :tactical_eager_loading
      Sequel::Model.plugin :timestamps, update_on_create: true
      Sequel::Model.plugin :touch
      Sequel::Model.plugin :update_or_create
      Sequel::Model.plugin :uuid
      Sequel::Model.plugin :validate_associated
      Sequel::Model.plugin :validation_helpers

      Sequel::Model.db.loggers << Rails.logger # FIXME: This double logs, and it spits out db metadata on model initialization
    end

    config.middleware.insert_before Rack::Sendfile, Rack::SslEnforcer, only_environments: 'production'
  end
end
