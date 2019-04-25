module RailsProfile
  class Engine < ::Rails::Engine

    config.factory_bot.definition_file_paths += Dir["#{config.root}/test/factories"] if defined?(FactoryBotRails)

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
    end

    initializer 'rails_profile.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_profile_manifest.js']
    end

  end
end
