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

    before do
      @results = {}

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

    post '/determinerow' do
      @id_clicked = params[:id]

      puts "id clicked:"
      puts @id_clicked

      @company_info = Linkedin.get_company_info(@id_clicked)

      pp @company_info

      @count,@email,@industry,@name,@phone,@status,@type,@url = Linkedin.parse_info(@company_info)
      
    end


    post '/' do
      @company_name = params[:company_name]
      company_id   = Linkedin.get_company_id(@company_name.downcase.gsub(" ","%20"))

      #Based on the keyword, this returns all the results possible:
      @search_results_ids = Linkedin.get_company_id_all(@company_name.downcase.gsub(" ","%20"))

      pp @search_results_ids
      #puts "------ Output-----"

      i = 0
      #puts "Search Results Query:"
      
      @search_results_ids.each do |id|
          
          company_info = Linkedin.get_company_info(id)

          @name_search,@url_search, @id_search = Linkedin.parse_info_search(company_info)
          
          @results[i] = {"company" => @name_search, "url" => @url_search, "id" => @id_search}

          i = i + 1
      end

      #pp @results

      #puts "TESTING------------>"

      #@results.each do |key, value|
       # puts "key:"
       # puts key
       # puts "value:"
       # puts value

       # value.each do |k, v|
       #   puts "inner key:"
       #   puts k
       #   puts "inner value:"
       #   puts v
       # end
       
      #end

  

      #company_info = Linkedin.get_company_info(company_id)

      #@count,@email,@industry,@name,@phone,@status,@type,@url = Linkedin.parse_info(company_info)



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