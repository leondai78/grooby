module Grooby
	class Course
		attr_accessor :major, :number
		def initialize(*args)
			yield self if block_given?
		end
	end
end
