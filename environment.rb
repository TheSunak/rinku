# Require additional configuration file if it exists.
require './config/authentication' if File.exists?('./config/authentication.rb')

# Include Sinatra libraries.
require 'sinatra/base'
require 'sinatra/reloader'

# Include support libraries.
require 'active_support/core_ext/hash/conversions'
require 'json'
require 'pp'

# Include all models (.rb files) in /lib/*/
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end

# Include debug capabilities in development.
configure :development do
  require 'better_errors'
  require 'binding_of_caller'
  require 'pry-debugger'

  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)

  register Sinatra::Reloader
  also_reload 'lib/*/*.rb'
end