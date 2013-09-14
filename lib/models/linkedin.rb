class Linkedin
	attr_reader :access_token, :consumer

	def initialize
		# Setup LinkedIn API client.
		@consumer 		= OAuth::Consumer.new(ENV['linkedin_api_key'], ENV['linkedin_secret_key'])
		@access_token = OAuth::AccessToken.new(@consumer, ENV['linkedin_oauth_token'], ENV['linkedin_oauth_secret'])
	end

end

<<-instructions

In order to make an API call:

	l = Linkedin.new
	body = l.access_token.get("http://api.linkedin.com/v1/company-search?keywords=salesforce.com&sort=relevance").body
	hash = Hash.from_xml(body)

instructions