$:.unshift File.dirname(__FILE__).chomp('unittests')<<'lib' # add library to path
require 'generic'
#require 'watir/process'

$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.monitor.click
g.sensr.click
#************Relative Humidity Test*********************
sleep 3
id = "2 -  1"
id = id.to_s
g.sensrid(id).click  #Relative Humidity
g.s_status.click
g.s_events.click
g.s_settgs.click
g.s_ratings.click


#******************Temperature Test*******************
id =  "2 -  2"
id = id.to_s
g.sensrid(id).click  #Temperature
g.s_status.click
g.s_events.click
g.s_settgs.click
g.s_ratings.click

#**************************Door Closure Test**************
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '3 -  1-1').click
id = "3 -  1-1"
id = id.to_s
g.sensrid(id).click
g.s_status.click
g.s_events.click
g.s_settgs.click
g.s_ratings.click

#**************************Contact Closure Test**************
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '4 -  1-1').click
id = "4 -  1-1"
id = id.to_s
g.sensrid(id).click
g.s_status.click
g.s_events.click
g.s_settgs.click
g.s_ratings.click

#**************Sensors Sort Test*******************************
g.s_idsort.click
g.s_typesort.click
g.s_label.click


