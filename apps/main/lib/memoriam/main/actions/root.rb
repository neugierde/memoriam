require "web_pipe"
require "memoriam/main/web"

module Memoriam
  module Main
    module Actions
      class Root
        include WebPipe

        compose :web, Web.new

        plug(:view) do |conn|
          conn.view('views.welcome')
        end
      end
    end
  end
end
