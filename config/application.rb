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
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weltzeit
  class Application < Rails::Application
    # added by hyper-rails
    config.eager_load_paths += %W(#{config.root}/app/models/public)
    # TODO https://github.com/ruby-hyperloop/hyper-rails/issues/4 config.eager_load_paths += %W(#{config.root}/app/views/components)
    config.autoload_paths += %W(#{config.root}/app/models/public)
    # TODO https://github.com/ruby-hyperloop/hyper-rails/issues/4 config.autoload_paths += %W(#{config.root}/app/views/components)
    config.assets.paths << ::Rails.root.join('app', 'models').to_s
  end
end
