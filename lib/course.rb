module Grooby
	class Course
		attr_accessor :major, :number

		def initialize(*args)
			defaults = {
				major: "",
				number: "",
				prereqs: [],
				offered: []
			}

			if args[0].is_a? String
				@major = parse_major args[0]
				@number = parse_number args[0]
			elsif args[0].is_a? Hash
				props = defaults.merge args[0]
				@major = props[:major]
				@number = props[:number]
			end
			
			yield self if block_given?
		end

		private
			def	parse_major string
				string.split(' ').first
			end

			def parse_number string
				string.split(' ').last
			end
	end
end
