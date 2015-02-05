module Grooby
	class Parser
		def self.course_major string
			string.split(' ').first
		end

		def self.course_number string
			string.split(' ').last
		end
	end
end
