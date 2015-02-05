module Grooby
	class Course
		attr_accessor :major, :number
		def initialize(*args)
			raise ArgumentError.new "Must initialize with values" if args == nil && !block_given?
			yield self if block_given?
		end
	end
end
