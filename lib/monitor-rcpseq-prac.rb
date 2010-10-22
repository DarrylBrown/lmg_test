$:.unshift File.dirname(__FILE__).chomp('snippets')<<'lib' # add library to path
require 'generic'
#require 'watir/process'

$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.monitor.click
g.rcp_sequence.click

puts "Enter the Receptacle Name"
rcpname = gets.chomp
rcpname=rcpname.to_s

puts "Enter the Receptacle Id"
rcpid = gets.chomp
rcpid=rcpid.to_s

puts "Enter the name or id" 
name_id = gets.chomp
name_id = name_id.to_s
n_id = name_id.include? "R"
puts "#{n_id}"
if (n_id == true)
g.rcpname(name_id).click
else
g.rcpid(name_id).click
end

g.rcp_sequence.click
sleep 5
g.label_sort.click
g.id_sort.click
g.onoff_sort.click
g.control_sort.click
g.status_sort.click
delay = g.rcp_table(11,1).text
puts "Delay :- #{delay}"
if (n_id == true)
g.rcpname(name_id).click
else
g.rcpid(name_id).click
end