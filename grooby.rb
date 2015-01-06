## Grooby

require "nokogiri"
require "open-uri"

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

$prereq = "Prerequisite:"
$page = Nokogiri::HTML(open("#{courses}?Prefix=#{course_prefix}"))

$course_results = $page.css(".courseresultstable")

$course_list = {}
# Initial scrape:
$course_results.each do |table|
  course_id = table.children[1].children[1].css('b').text
  course_id = clean_up_course_id(course_id)
  $course_list[course_id] = {}
  table.css("tr").each_with_index do |row,i|
    next if i == 0
    category = row.children[0].text
    info = row.children[1].text
    $course_list[course_id][category] = info
  end
end
# Clean up the data:
$course_list.keys.each do |key|
  prereqs = $course_list[key][$prereq]
  $course_list[key][$prereq] = clean_up_prereqs(prereqs) if prereqs
  # puts "Prereqs for #{key}:"
  # puts $course_list[key]["Prerequisite:"]
end

# Generates a complete graph of all courses pulled from the syllabus

g=digraph do 
  node course_prefix
  $course_list.keys.each do |key|
    course = $course_list[key]
    prereqs = course[$prereq]
    node(key) if key
    prereqs.each do |pre|
      node(key) << pre unless pre.include? 'ermission' || pre == "s"
    end if prereqs
  end

  save "simple", "png"
end

# Annotates the graph if 
