require 'generic'
#require 'watir/process'
 
$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.control.click
g.login('10.130.92.34','Liebert','Liebert')
g.pdu_exp.click
#g.mstatus.click
g.cntrl_settg.click
g.usr_lbl.set('User Label1')
#g.pdu(2).click
#g.scroll(3).click

=begin
ac_en = g.pdustatus_param.text
p ac_en
ac_en1 = g.pdustatus_param1(2).text
p ac_en1
ac_en2 = g.pdustatus_param2(1).text
p ac_en2
ac_en3 = g.pdustatus_param3(2,1).text
p ac_en2
#begin

status_header = g.pdustatus_param(1,1).text
puts "Supported Status Header is #{status_header}"
value_header = g.pdustatus_param(1,2).text
puts "Supported Value Header is #{value_header}"
unit_header = g.pdustatus_param(1,3).text
puts "Supported Unit Header is #{value_header}"

accum_energy = g.pdustatus_param(2,1).text
puts "Parameter1 is #{accum_energy}"
value_header = g.pdustatus_param(2,2).text
puts "Value1 is #{value_header}"
unit_header = g.pdustatus_param(2,3).text
puts "Unit1 is #{value_header}"
ac_en = $ie.frame(:index, 3).frame(:index, 3).table(:index, 9)[2][1].text
puts"#{ac_en}"

status_header = g.pdustatus_param(3,1).text
puts "Parameter2 is #{status_header}"
value_header = g.pdustatus_param(3,2).text
puts "Value2 is #{value_header}"
unit_header = g.pdustatus_param(3,3).text
puts "Unit2 is #{value_header}"

status_header = g.pdustatus_param(4,1).text
puts "Parameter3 is #{status_header}"
value_header = g.pdustatus_param(4,2).text
puts "Value3 is #{value_header}"
unit_header = g.pdustatus_param(4,3).text
puts "Unit3 is #{value_header}"

status_header = g.pdustatus_param(5,1).text
puts "Parameter4 is #{status_header}"
value_header = g.pdustatus_param(5,2).text
puts "Value4 is #{value_header}"
unit_header = g.pdustatus_param(5,3).text
puts "Unit4 is #{value_header}"


status_header = g.pdustatus_param(6,1).text
puts "Parameter5 is #{status_header}"
value_header = g.pdustatus_param(6,2).text
puts "Value5 is #{value_header}"
unit_header = g.pdustatus_param(6,3).text
puts "Unit5 is #{value_header}"

status_header = g.pdustatus_param(7,1).text
puts "Parameter6 is #{status_header}"
value_header = g.pdustatus_param(7,2).text
puts "Value7 is #{value_header}"
unit_header = g.pdustatus_param(7,3).text
puts "Unit7 is #{value_header}"

status_header = g.pdustatus_param(8,1).text
puts "Parameter8 is #{status_header}"
value_header = g.pdustatus_param(8,2).text
puts "Value8 is #{value_header}"
unit_header = g.pdustatus_param(8,3).text
puts "Unit8 is #{value_header}"

status_header = g.pdustatus_param(9,1).text
puts "Parameter9 is #{status_header}"
value_header = g.pdustatus_param(9,2).text
puts "Value9 is #{value_header}"
unit_header = g.pdustatus_param(9,3).text
puts "Unit9 is #{value_header}"
#end
=end