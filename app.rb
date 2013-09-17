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

    before do
      @results = []
    end

    # Routes
    # => define controller actions for application.

    get '/' do
      erb :index
    end

    post '/' do
      @company_name = params[:company_name]

      company_id = Linkedin.get_company_id(@company_name.downcase.gsub(" ","%20"))
      search_ids = Linkedin.get_search_ids(@company_name.downcase.gsub(" ","%20"))
      
      search_ids.each do |id|
          company_info = Linkedin.get_company_info(id)
          name_search, url_search, id_search = Linkedin.parse_info_search(company_info)
          @results << {"company" => name_search, "url" => url_search, "id" => id_search}
      end

      puts @results

      erb :index
    end

    post '/determinerow' do
      id_clicked = params[:id]
      company_info = Linkedin.get_company_info(id_clicked)
      
      @count,@email,@industry,@name,@phone,@status,@type,@url = Linkedin.parse_info(company_info)
      
      puts @count,@email,@industry,@name,@phone,@status,@type,@url
      # return @count,@email,@industry,@name,@phone,@status,@type,@url
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