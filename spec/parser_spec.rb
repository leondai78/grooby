RSpec.describe Grooby::Parser do
	describe "#course_major" do
		it "should recognize 'CSCI 3030' as 'CSCI'" do
			string = Grooby::Parser.course_major "CSCI 3030"
			expect(string).to eq "CSCI"
		end
	end

	describe "#course_number" do
		it "should recognize 'CSCI 3030' as '3030'" do
			string = Grooby::Parser.course_number "CSCI 3030"
			expect(string).to eq "3030"
		end
	end
end
