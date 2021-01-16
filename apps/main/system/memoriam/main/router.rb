require "hanami/router"
require_relative "container"

module Memoriam
  module Main
    ROUTER = Hanami::Router.new do
      root to: Container["actions.root"]
    end
  end
end
