require_relative 'boot'

require 'rspotify'

require 'rails/all'

RSpotify.authenticate("2bddb2de8f6b4b7792f99cdb8aecbe19", "a5f9a55ab0db42f68a3c02cdab76fb61")


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SpotifyPlaylister
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
