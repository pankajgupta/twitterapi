class CommandParser
	

	VALID_COMMANDS = [
		"lookup_ids",
		"placeholder"
	]

	def initialize(base_args, command_args)
		@base_args = base_args
		@command_args = command_args
	end

	def parse!

		if @base_args.nil? || @base_args.empty?
			puts base_parser({})
			exit
		end

		base_options = {}
		ps = base_parser(base_options)
		ps.order!(@base_args)
		#puts "base_options:", base_options

		command_options = {}
		ps = command_parser(base_options[:command], command_options)
		ps.order!(@command_args)

		[base_options, command_options]
	end

	private

	def base_parser(options)
		ps = OptionParser.new do |opts|
			opts.banner = "Usage: tapi [-?] [-o oauth_file] -c COMMAND [command_options]"
			opts.on("-o", "--oauth_file filename", String, "Oauth credentials file name") do |filename|
				options[:oauth_file] = filename
			end
			opts.on("-c", "--command command", "Command or API method") do |command|
				options[:command] = command
			end
			opts.on("-?", "--help", "Show help") do
				puts opts
				exit
			end
		end
	end

	def command_parser(command, options)
		case command
		when "lookup_ids"
			OptionParser.new do |opts|
				opts.banner = "Usage: ... -c lookup_ids [-u user_id1[, user_id2, ...]]"
				opts.on("-u", "--user_ids USER_IDs", Array, "User id(s) to lookup") do |arg|
					options[:user_ids] = arg
				end
				opts.on("-?", "--help", "Show help") { puts opts; exit }
			end
		else 
			puts "ERROR:Invalid command '#{command}' "
			puts base_parser({})
			exit
		end
	end
end
