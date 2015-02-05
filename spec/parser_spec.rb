RSpec.describe Grooby::Parser do
	describe "#parse_course_major" do
		it "should recognize 'CSCI 3030' as 'CSCI'" do
			string = Grooby::Parser.parse_course_major "CSCI 3030"
			expect(string).to eq "CSCI"
		end
	end

	describe "#parse_course_number" do
		it "should recognize 'CSCI 3030' as '3030'" do
			string = Grooby::Parser.parse_course_number "CSCI 3030"
			expect(string).to eq "3030"
		end
	end
end
