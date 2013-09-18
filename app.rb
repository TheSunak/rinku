# Require all Ruby gems located in Gemfile.
require 'bundler'
Bundler.require

# Include all models in lib/*/ folders.
require_relative 'environment'

module Rinku
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

    post '/' do
      @company_name   = params[:company_name]
      
      search_ids      = Linkedin.get_search_ids(@company_name.downcase.gsub(" ","%20"))
      @search_results = Linkedin.get_search_results(search_ids)

      erb :index
    end

    # ==> JSON post from :index form.
    post '/determinerow' do
      id_clicked   = params[:id]
      
      company_info = Linkedin.get_company_result(id_clicked)
      row_results  = Linkedin.parse_info(company_info)
      
      row_results.to_json
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