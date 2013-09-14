# Require additional configuration file if it exists.
require './config/authentication' if File.exists?('./config/authentication.rb')

# Include all models (.rb files) in /lib/*/

Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end