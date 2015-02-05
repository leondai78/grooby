require 'parser'

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
				@major = Grooby::Parser.parse_course_major args[0]
				@number = Grooby::Parser.parse_course_number args[0]
			elsif args[0].is_a? Hash
				props = defaults.merge args[0]
				@major = props[:major]
				@number = props[:number]
			end
			
			yield self if block_given?
		end
	end
end
