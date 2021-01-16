require "hanami/router"
require "memoriam/main/router"

module Memoriam
  ROUTER = Hanami::Router.new do
    mount Main::ROUTER, at: '/'
  end
end
