# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( main-style.css )
Rails.application.config.assets.precompile += %w( fonts/font-awesome/css/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( 320.css )
Rails.application.config.assets.precompile += %w( 480.css )
Rails.application.config.assets.precompile += %w( 640.css )
Rails.application.config.assets.precompile += %w( 768.css )
Rails.application.config.assets.precompile += %w( 992.css )
Rails.application.config.assets.precompile += %w( 1200.css )
Rails.application.config.assets.precompile += %w( slick.css )
Rails.application.config.assets.precompile += %w( slick-theme.css )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
