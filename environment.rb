# Require additional configuration file if it exists.
require './config/authentication' if File.exists?('./config/authentication.rb')

# Setup LinkedIn API client.
client = LinkedIn::Client.new(ENV['linkedin_api_key'], ENV['linkedin_secret_key'])
client.authorize_from_access(ENV['linkedin_oauth_token'], ENV['linkedin_oauth_secret'])

# Include all models (.rb files) in /lib/*/

Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end