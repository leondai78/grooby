module Grooby
	class Course
		attr_reader :major, :number, :offered, :prereqs, :required_for
		def initialize(major, number, options={})
			@major = major 
			@number = number
			@offered = options[:offered]
			@prereqs = options[:prereqs]
			@required_for = options[:required_for]
		end
	end
end
