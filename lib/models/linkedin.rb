class Linkedin
	attr_accessor :client

	def initialize
		# Setup LinkedIn API client.
		@client = LinkedIn::Client.new(ENV['linkedin_api_key'], ENV['linkedin_secret_key'])
		@client.authorize_from_access(ENV['linkedin_oauth_token'], ENV['linkedin_oauth_secret'])
	end
end