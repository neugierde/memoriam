require "memoriam/main/view"

module Memoriam
  module Main
    module Views
      class Welcome < View
        configure do |config|
          config.template = "welcome"
        end
      end
    end
  end
end
