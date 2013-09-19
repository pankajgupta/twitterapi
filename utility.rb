#shared code containing some utility functions



class Utility

	# splits cmd line args into the base part that includes the command to be run,
	# and the command-specific args
	def self.split_args(args)
		split_index = args.index("-c") || args.index("--command")
		return [args, []] unless split_index

	    base_args = args[0..split_index+1]
	    command_args = args[split_index+2..-1] || []
	    [base_args, command_args]
  	end

end
