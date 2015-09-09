require 'rubygems'
require 'bundler/setup'

Bundler.require :default

Dotenv.load

Dir[ "./api/*.rb" ].each do |file|
  require file
end

require './api'

$DB = Sequel.connect(
  adapter:  :mysql2,
  database: :restful,
  user:     ENV['DB_USER'],
  password: ENV['DB_PASSWORD']
)
  # 'mysql2://m4t@localhost/restful'

module Restful
  class App
    def initialize
      @filenames = ['', '.html', 'index.html', '/index.html']
      @rack_static = ::Rack::Static.new(
        lambda { [404, {}, []] },
        root: File.expand_path('../public', __FILE__),
        urls: ['/']
      )
    end

    def call( env )
      response = Restful::API.call( env )

      if response[1]['X-Cascade'] == 'pass'
        # static files
        request_path = env['PATH_INFO']
        @filenames.each do |path|
          response = @rack_static.call(env.merge('PATH_INFO' => request_path + path))
          return response if response[0] != 404
        end
      end

      return response
    end
  end
end

run Restful::App.new
