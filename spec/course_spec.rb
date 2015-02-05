require_relative '../lib/course.rb'

RSpec.describe Grooby::Course do
	describe "#initialize" do
		it "can initialize with course string" do
			course = nil
			expect { course = Grooby::Course.new "CSCI 3030" }.to_not raise_error
			expect(course.major).to eq "CSCI"
			expect(course.number).to eq "3030"
		end

		it "can initialize with options hash only" do
			course = nil
			expect { course = Grooby::Course.new major: "CSCI", number: "3030" }.to_not raise_error
			expect(course.major).to eq "CSCI"
			expect(course.number).to eq "3030"
		end

		it "can initialize with block" do
			course = nil
			expect {
				course = Grooby::Course.new do |c|
					c.major = "CSCI"
					c.number = "3030"
				end
			}.to_not raise_error
			expect(course.major).to eq "CSCI"
			expect(course.number).to eq "3030"
		end
	end
end
			
