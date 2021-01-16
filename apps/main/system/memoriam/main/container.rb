require "pathname"
require "dry/web/container"
require "dry/system/components"

module Memoriam
  module Main
    class Container < Dry::Web::Container
      require root.join("system/memoriam/container")
      import core: Memoriam::Container

      configure do |config|
        config.root = Pathname(__FILE__).join("../../..").realpath.dirname.freeze
        config.logger = Memoriam::Container[:logger]
        config.default_namespace = "memoriam.main"
        config.auto_register = %w[lib/memoriam/main]
      end

      load_paths! "lib"
    end
  end
end
