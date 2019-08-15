require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Armand
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # This overwrites the configuration for the routes to which the controller is being used. 
    # Comment this out in order to get the full rails routing error for debugging.
    config.exceptions_app = self.routes 

    config.to_prepare do
      Hyrax::CurationConcern.actor_factory.use UpdateArkActor
      Hyrax::CurationConcern.actor_factory.use UpdateAspaceActor
    end

  end
end
