require "dry/web/container"
require "dry/system/components"
require 'dry-monitor'
Dry::Monitor.load_extensions(:rack)

module Memoriam
  class Container < Dry::Web::Container
    configure do
      config.name = :memoriam
      config.listeners = true
      config.default_namespace = "memoriam"
      config.auto_register = %w[lib/memoriam]
    end

    load_paths! "lib"
  end
end
