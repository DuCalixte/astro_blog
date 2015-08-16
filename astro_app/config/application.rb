require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
# require 'active_resource/railtie'
require 'rails/test_unit/railtie'
require 'sprockets/railtie'

require 'haml'
require 'haml/template'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

require 'i18n/backend/fallbacks'
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

#I18N_FALLBACKS = [eng: :en, jpn: :jp]

module AstroApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Add 'lib/views' to the list of directories that get searched when trying to render a view/partial
    config.paths['app/views'].push('lib/view')

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    #To avoid this warning during test or any form of bundle exec:
    #[deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
    config.i18n.enforce_available_locales = false

    # How localization works...if a non-eng yml file is present, setting fallback to true will cause
    # i18n to fallback to the default_locale if 1) the key is missing or 2) the non-eng.yml file is missing.
    # (Incidentally - If fallback is not activated, and there is non-eng.yml, but there is no key, Rails issuse
    # a translation-missing message.  If the non-eng.yml is present, there is no fallback setting, and
    # the key is missing, i18n will try to be smart, and take the eng.yml key,
    # remove the underscores, and titlecase the string).
    #config.i18n.fallbacks = I18N_FALLBACKS

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :eng

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

    # Enable app status so the world knows we're running
    # config.middleware.use Rack::AppStatus, :sensors => [:simple]

  end
end