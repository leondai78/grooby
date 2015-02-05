require_relative '../lib/course.rb'

RSpec.describe Grooby::Course do
	describe "#initialize" do
		it "errors with empty initializer" do
			expect { course = Grooby::Course.new }.to raise_error(ArgumentError)
		end

		it "can initialize with course string" do
			expect { course = Grooby::Course.new "CSCI 3030" }.to_not raise_error
		end

		it "can initialize with options hash" do
			expect { course = Grooby::Course.new major: "CSCI", number: "3030" }.to_not raise_error

		end

		it "can initialize with block" do
			expect {
				course = Grooby::Course.new do |c|
					c.major = "CSCI"
					c.number = "3030"
				end
			}.to_not raise_error
		end
	end
end
			
