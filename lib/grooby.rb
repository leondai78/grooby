# grooby.rb

require "nokogiri"
require "open-uri"
require "graph"

module Grooby

  class Scraper
    
    COURSES_HOME ||= "http://bulletin.uga.edu/CoursesHome.aspx"
    PREREQ ||= "Prerequisite:"
    CSS_SELECTOR ||= ".courseresultstable"

    def initialize(prefix="CSCI")
      @prefix = prefix
      self
    end

    def scrape
      courses_path = "#{COURSES_HOME}?Prefix=#{@prefix}"
      
      tables = Nokogiri::HTML(open(courses_path)).css(CSS_SELECTOR)

      tables.each do |table|
        course_id = get_course_id table
        
        course_list[course_id] = {}
       
        table.css("tr").each_with_index do |row,i|
          next if i == 0
          category = row.children[0].text
          info = row.children[1].text
          course_list[course_id][category] = info
        end
      
      end  
    
    end
    
    private

      def prune_course_id(id)
        id.split.map { |a| 
          a.split('/').
            first.
            gsub(/\([A-Z]*\)/, "").
            split('-').
            first
        }.join.delete('[]()')
        # what is this, perl?
      end

      def get_course_id(table)
        prune_course_id(
          table.css('tr')[1].css('b').text
        )
      end
  
  end
end
