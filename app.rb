# Require all Ruby gems located in Gemfile.
require 'bundler'
Bundler.require

require 'sinatra/base'
require 'sinatra/reloader'

require 'better_errors'
require 'binding_of_caller'
require 'pry-debugger'

# Include all models in lib/*/ folders.
require_relative 'environment'

module Rinku
  class App < Sinatra::Application

    # Configure Options
    # => set configuration options for application.

    # ==> Set default paths of application.
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    configure :development do
      # ==> Use Better Errors debugger in development.
      use BetterErrors::Middleware
      BetterErrors.application_root = File.expand_path('..', __FILE__)

      # ==> Use Sinatra Reloader for real time modifications.
      register Sinatra::Reloader
    end

    # Routes
    # => define controller actions for application.

    # ==> Render index page.
    get '/' do
      erb :index
    end

    # ==> POST from main button on index page.
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
      row_results  = Linkedin.collect_data(company_info)
      
      row_results.to_json
    end

    get '/boom' do
      raise 'Oops! See you at the better_errors error page!'
    end

    # Helpers
    # => define helper methods for application.

    helpers do
      # ==> Enable partials in the initial form.
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end