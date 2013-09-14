# Require all Ruby gems located in Gemfile.
require 'bundler'
Bundler.require

# Include all models in lib/*/ folders.
require_relative 'environment'

# Rename 'AppName' to name of choice.
# => Don't forget to update config.ru as well.

module AppName
  class App < Sinatra::Application

    # Configure Options
    # => set default paths of application.

    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    # Database
    # => delete if not needed.

    set :database, "sqlite3:///database.db"

    # Filters
    # => add route filters if necessary.

    # Routes
    # => define controller actions for application.

    get '/' do
      erb :index
    end

    # Helpers
    # => define helper methods for application.

    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end
