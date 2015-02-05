module Grooby
	class Parser
		def self.parse_course_major string
			string.split(' ').first
		end

		def self.parse_course_number string
			string.split(' ').last
		end
	end
end
