RSpec.describe Grooby::Parser do
	describe "#course_major" do
		def parse string
			Grooby::Parser.course_major string
		end

		it "should recognize 'CSCI 3030' as 'CSCI'" do
			string = parse "CSCI 3030"
			expect(string).to eq "CSCI"
		end

		it "should recognize 'CSCI 6240H' as 'CSCI'" do
			string = parse "CSCI 4200H"
			expect(string).to eq "CSCI"
		end

		it "should recognize 'CSCI/MATH' as 'CSCI/MATH'" do
			string = parse "CSCI/MATH 2260"
			expect(string).to eq "CSCI/MATH"
		end

		it "should ignore whitespace" do
			string = parse "    CSCI        2260    "
			expect(string).to eq "CSCI"
		end
	end

	describe "#course_number" do
		def parse string
			Grooby::Parser.course_number string
		end

		it "should recognize 'CSCI 3030' as '3030'" do
			string = parse "CSCI 3030"
			expect(string).to eq "3030"
		end

		it "should recognize 'CSCI 4200H' as '4200H'" do
			string = parse "CSCI 4200H"
			expect(string).to eq "4200H"
		end

		it "should recognize 'CSCI 4200/6200' as '4200/6200'" do
			string = parse "CSCI 4200/6200"
			expect(string).to eq "4200/6200"
		end
		
		it "should ignore whitespace" do
			string = parse "   CSCI		3030					"
			expect(string).to eq "3030"
		end
	end
end
