class Linkedin

	@@consumer 		 = OAuth::Consumer.new(ENV['linkedin_api_key'], ENV['linkedin_secret_key'])
	@@access_token = OAuth::AccessToken.new(@@consumer, ENV['linkedin_oauth_token'], ENV['linkedin_oauth_secret'])

	@@fields 			 = ["email-domains","company-type","website-url","industries","status","employee-count-range","locations:(contact-info:(phone1))"]

	# Getter methods for class variables.

	def self.fields
		@@fields
	end

	def self.consumer
		@@consumer
	end

	def self.access_token
		@@access_token
	end

	# Helper methods.

	def self.field_string
		"(" + fields.join(",") + ")"
	end

	# Search API for LinkedIn.

	def self.get_company_id(company_name)
		body = access_token.get("http://api.linkedin.com/v1/company-search?keywords=#{company_name}.com&sort=relevance").body
		hash = Hash.from_xml(body)
		hash["company_search"]["companies"]["company"][0]["id"]
	end

	def self.get_company_info(company_id)
		body = access_token.get("http://api.linkedin.com/v1/companies/#{company_id}:#{field_string}").body
		hash = Hash.from_xml(body)
	end

end

<<-instructions

In order to make an API call:

	l = Linkedin.new
	body = l.access_token.get("http://api.linkedin.com/v1/company-search?keywords=salesforce.com&sort=relevance").body
	hash = Hash.from_xml(body)

instructions