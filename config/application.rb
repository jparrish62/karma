require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load
KARMA_API_KEY  = ENV['GOOGLE_API_CLIENT_KEY']
CLIENT_ID      = ENV['GOOGLE_API_CLIENT_ID']
CLIENT_SECRET  = ENV['GOOGLE_API_CLIENT_SECRET']
CALENDAR_SCOPE = ENV['AUTH_CALENDAR_READWRITE']

module SalonKarma
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
