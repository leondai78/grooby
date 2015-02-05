require_relative '../lib/course.rb'

RSpec.describe Grooby::Course do
	describe "#initialize" do
		before(:each) do
			@course = nil
		end

		it "can initialize with @course string" do
			expect { @course = Grooby::Course.new "CSCI 3030" }.to_not raise_error
			expect(@course.major).to eq "CSCI"
			expect(@course.number).to eq "3030"
		end

		it "can initialize with options hash only" do
			expect { @course = Grooby::Course.new major: "CSCI", number: "3030" }.to_not raise_error
			expect(@course.major).to eq "CSCI"
			expect(@course.number).to eq "3030"
		end

		it "can initialize with block" do
			expect {
				@course = Grooby::Course.new do |c|
					c.major = "CSCI"
					c.number = "3030"
				end
			}.to_not raise_error
			expect(@course.major).to eq "CSCI"
			expect(@course.number).to eq "3030"
		end
	end

	describe "#prereqs" do
		before(:each) do
			@course = Grooby::Course.new
		end

		it "should be empty array if uninitialized" do
			expect(@course.prereqs).to eq []
		end
	end

	describe "#add_prereq" do
		before(:each) do
			@course = Grooby::Course.new
		end

		it "should error when non-course added" do
			expect {
				@course.add_prereq "i am not a course"
			}.to raise_error ArgumentError
		end

		it "should add new course when course added" do
			expect(@course.prereqs.size).to eq 0
			@course.add_prereq Grooby::Course.new("CSCI 3030")
			expect(@course.prereqs.size).to eq 1
		end
	end
end
			
