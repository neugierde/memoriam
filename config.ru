require_relative "system/boot"

# MethodOverride middleware has to be used at the router level, so that
# `hanami-router` can be aware of it
use Rack::MethodOverride

run Memoriam::ROUTER
