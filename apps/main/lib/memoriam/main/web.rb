require "web_pipe"
require 'web_pipe/plugs/content_type'
require "web_pipe/plugs/config"
require "rack/csrf"
require "rack/session/cookie"
require 'rack-flash'
require "memoriam/main/container"

WebPipe.load_extensions(
  :container,
  :cookies,
  :flash,
  :dry_schema,
  :dry_view,
  :params,
  :redirect,
  :router_params,
  :session,
  :url
)

module Memoriam
  module Main
    class Web
      include WebPipe
  
      use :cookies, Rack::Session::Cookie, key: "main.session", secret: Container["core.settings"].session_secret
      use :csrf, Rack::Csrf, raise: true
      use :flash, Rack::Flash
  
      plug :config, WebPipe::Plugs::Config.(
        container: Container,
  
        view_context: lambda do |conn|
          {
            flash: conn.flash,
            csrf_token: Rack::Csrf.token(conn.env),
            csrf_metatag: Rack::Csrf.metatag(conn.env),
            csrf_tag: Rack::Csrf.tag(conn.env)
          }
        end,
  
        sanitization_handler: lambda do |conn, result|
          conn.
            set_status(500).
            set_response_body("Params #{conn.params} do not conform with the schema: #{result.errors.inspect}").
            halt
        end
      )
  
      plug :content_type, WebPipe::Plugs::ContentType.('text/html')
    end
  end
end
