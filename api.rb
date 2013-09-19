#'oauth_credentials.yml'

class TwitterApi
	API_HOST = "api.twitter.com"

	def initialize(oauth_credentials_file)

		@oauth_credentials = begin
			File.open(oauth_credentials_file) { |f| YAML.load(f) }
		rescue Errno::ENOENT
			$stderr.puts <<-MESSAGE

			OAuth credentials missing. Please provide a file #{oauth_credentials_file} with the following format:
			---
			:consumer_key: <your consumer key>
			:consumer_secret: <your consumer secret>
			:token: <your access token>
			:token_secret: <your access token secret>

			MESSAGE
			exit(-1)
		end
	end

	def lookup(user_ids)
		user_ids_str = user_ids.join(',')
		$stderr << "Looking up user ids #{user_ids_str}...\n"
		response = get("/1.1/users/lookup.json?user_id=#{user_ids_str}")
		#debugger
		if response.code == '404'
			$stderr << "Returned 404. No id found!\n"
		else
			users = JSON.parse(response.body)
			#store resulting users in a hash to maintain the order of ids in the output
			userinfo = Hash.new
			users.each do |user|
				userinfo[user['id']] = user
			end
			user_ids.each do |id|
				printf "%d:", id.to_i
				if user = userinfo[id.to_i]
					puts "#{user['screen_name']}"
				else
					puts "N/A"
				end
			end
		end
	end

	private

	def get(url)
		complete_url = "https://#{API_HOST}#{url}"
		#debugger
		authorization = SimpleOAuth::Header.new("GET", complete_url, {}, @oauth_credentials)
		request = Net::HTTP::Get.new(url)
		request['Authorization'] = authorization.to_s
		result = connection.request(request)
		status_code = result.code
		raise "Unexpected status code #{status_code}" unless ['200', '404'].include?(status_code)
		result
	end

  def connection
    @connection ||= Net::HTTP.new(API_HOST, Net::HTTP.https_default_port).tap do |connection|
      connection.use_ssl=true
    end
  end

end

######==================BEGINNING OF MAIN==============


######==================END OF MAIN==============
