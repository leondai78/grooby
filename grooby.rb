## Grooby

require "nokogiri"
require "open-uri"
require "graph"

#hoorah MONKEY PATCH
class Graph
  class Node
    def children

    end

    def parents

    end
  end
end

def clean_up_course_id(raw_title)
  raw_title.split.map { |a| 
    a.split('/').first.gsub(/\([A-Z]*\)/, "").split('-').first
  }.join.delete('[]()')
  # what is this, perl?
end

def clean_up_prereqs(raw_prereqs)
  raw_prereqs.split(/or|and|:/).map { |p| 
    clean_up_course_id(p) 
  }.reject { |string|
    string == 'Atleastoneofthefollowing'
  }
end

courses = "http://bulletin.uga.edu/CoursesHome.aspx"
course_prefix = "CSCI"

PREREQ ||= "Prerequisite:"
page = Nokogiri::HTML(open("#{courses}?Prefix=#{course_prefix}"))

course_results = page.css(".courseresultstable")

course_list = {}
# Initial scrape:
course_results.each do |table|
  course_id = table.children[1].children[1].css('b').text
  course_id = clean_up_course_id(course_id)
  course_list[course_id] = {}
  table.css("tr").each_with_index do |row,i|
    next if i == 0
    category = row.children[0].text
    info = row.children[1].text
    course_list[course_id][category] = info
  end
end

# Clean up the data:
course_list.keys.each do |key|
  prereqs = course_list[key][PREREQ]
  course_list[key][PREREQ] = clean_up_prereqs(prereqs) if prereqs
  # puts "Prereqs for #{key}:"
  # puts course_list[key]["Prerequisite:"]
end

# Generates a complete graph of all courses pulled from the syllabus

g=digraph do 
  node course_prefix
  course_list.keys.each do |key|
    course = course_list[key]
    prereqs = course[PREREQ]
    node(key) if key
    prereqs.each do |pre|
      node(key) << pre unless pre.include? 'ermission' 
    end if prereqs
  end
  
  delete_node("s")
  delete_node("MATH")
  save "simple", "png"
end

# Annotates the graph if i've taken the course

courses_taken = %w(MATH 1113 CSCI1301 CSCI1302 CSCI2610 MATH2250)

# To see what the node is connected to:
# tree.edges["desired node"].keys 
# => ["array", "of", "nodes"]
#
t=g.dup
t.orient("BT")

# Take all of the children of the current courses:
courses_taken.each do |c| 
  courses_taken = courses_taken + t.edges[c].keys
end

# Remove duplicates:
courses_taken = courses_taken.uniq

courses_taken.each do |c|
  t.color("blue") << t.node(c)
  t.node(c).attributes  << 'taken = true'
end


# Invert so that classes now point to classes they are prereqs for:
t=t.invert
potentials = []
courses_taken.each do |c|
  required_for = t.edges[c].keys
  required_for.each do |r|
    unless t.node(r).attributes.include? 'taken = true'
      # puts "#{r} should not be taken because #{t.node(r).attributes.to_s}"
    end
  end
end

# Color taken nodes blue:
courses_taken.each do |c|
  t.color("blue") << t.node(c)
  t.node(c).attributes  << 'taken = true'
end
t.save 'avail_classes', 'png'

