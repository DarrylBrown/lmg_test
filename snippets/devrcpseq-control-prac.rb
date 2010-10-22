$:.unshift File.dirname(__FILE__).chomp('snippets')<<'lib' # add library to path
require 'generic'
#require 'watir/process'

$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.control.click_no_wait
g.login('10.130.92.34','Liebert','Liebert')
sleep 5
#*************************************Device Explorer*******************************
g.dev_exp.click
g.dev_exp.click
sleep 5
g.label_sort.click
g.id_sort.click
g.onoff_sort.click
g.control_sort.click
g.status_sort.click
g.select_all.set
g.select_all.clear
puts "Enter the RCP state"
rcpstat = gets.chomp
rcpstat = rcpstat.to_s
g.rcpstate.select_value("#{rcpstat}")
g.rcpstsave.click_no_wait
g.jsClick('Windows Internet Explorer', 'OK')
puts "Enter the lock state"
lck = gets.chomp
lck = lck.to_s
g.rcplckstate.select_value("#{lck}")
g.rcplcksave.click_no_wait
g.jsClick('Windows Internet Explorer', 'OK')
puts "Enter the Receptacle:"
lbl = gets.chomp
g.dev_label.set(lbl)
puts "Enter the name or id" #Make sure this is the same receptacle as entered at line 27
name_id = gets.chomp
name_id = name_id.to_s
n_id = name_id.include? "R"
puts "#{n_id}"
if (n_id == true)
g.rcpname(name_id).click
else
g.rcpid(name_id).click
end

#******************************Receptacle Sequence*************************
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

