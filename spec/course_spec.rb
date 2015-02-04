require_relative '../lib/course.rb'

RSpec.describe Grooby::Course do
	describe "#initialize" do
		it "errors with empty initializer" do
			expect { course = Grooby::Course.new }.to raise_error(ArgumentError)
		end
	end
end
			
