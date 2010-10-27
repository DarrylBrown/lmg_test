require 'generic'
#require 'watir/process'
 
$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.monitor.click
g.pdu_exp.click
g.pdu(2).click

#****************************PDU-Status********************
g.mstatus.click
puts"Status1 = #{g.status(2,1).text}"
puts"Value1 = #{g.status(2,2).text}"
puts"Unit1 = #{g.status(2,3).text}"

puts"Status2 = #{g.status(3,1).text}"
puts"Value2 = #{g.status(3,2).text}"
puts"Unit2 = #{g.status(3,3).text}"

puts"Status3 = #{g.status(4,1).text}"
puts"Value3 = #{g.status(4,2).text}"
puts"Unit3 = #{g.status(4,3).text}"

puts"Statu4 = #{g.status(5,1).text}"
puts"Value4 = #{g.status(5,2).text}"
puts"Unit4 = #{g.status(5,3).text}"

puts"Status5 = #{g.status(6,1).text}"
puts"Value5 = #{g.status(6,2).text}"
puts"Unit5 = #{g.status(6,3).text}"

puts"Status6 = #{g.status(7,1).text}"
puts"Value6 = #{g.status(7,2).text}"
puts"Unit6 = #{g.status(7,3).text}"

puts"Status7 = #{g.status(8,1).text}"
puts"Value7 = #{g.status(8,2).text}"
puts"Unit7 = #{g.status(8,3).text}"

puts"Status8 = #{g.status(9,1).text}"
puts"Value8 = #{g.status(9,2).text}"
puts"Unit8 = #{g.status(9,3).text}"
#***************************************************************************
#*********************************PDU Events******************************
g.mevents.click
puts"Event1 = #{g.events(2,2).text}"
puts"Value1 = #{g.events(2,3).text}"

puts"Event2 = #{g.events(3,2).text}"
puts"Value2 = #{g.events(3,3).text}"

puts"Event3 = #{g.events(4,2).text}"
puts"Value3 = #{g.events(4,3).text}"

puts"Event4 = #{g.events(5,2).text}"
puts"Value4 = #{g.events(5,3).text}"

puts"Event5 = #{g.events(6,2).text}"
puts"Value5 = #{g.events(6,3).text}"
#***************************************************************************
#*********************************PDU Settings******************************
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"

puts"Settings4 = #{g.settings(5,1).text}"
puts"Value4 = #{g.settings(5,2).text}"
puts"Unit4 = #{g.settings(5,3).text}"

puts"Settings5 = #{g.settings(6,1).text}"
puts"Value5 = #{g.settings(6,2).text}"
puts"Unit5 = #{g.settings(6,3).text}"

puts"Settings6 = #{g.settings(7,1).text}"
puts"Value6 = #{g.settings(7,2).text}"
puts"Unit6 = #{g.settings(7,3).text}"

puts"Settings7 = #{g.settings(8,1).text}"
puts"Value7 = #{g.settings(8,2).text}"
puts"Unit7 = #{g.settings(8,3).text}"

puts"Settings8 = #{g.settings(9,1).text}"
puts"Value8 = #{g.settings(9,2).text}"
puts"Unit8 = #{g.settings(9,3).text}"
#***************************************************************************
#*********************************PDU Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"

puts"Ratings4 = #{g.ratings(5,1).text}"
puts"Value4 = #{g.ratings(5,2).text}"
puts"Unit4 = #{g.ratings(5,3).text}"

puts"Ratings5 = #{g.ratings(6,1).text}"
puts"Value5 = #{g.ratings(6,2).text}"
puts"Unit5 = #{g.ratings(6,3).text}"

puts"Ratings6 = #{g.ratings(7,1).text}"
puts"Value6 = #{g.ratings(7,2).text}"
puts"Unit6 = #{g.ratings(7,3).text}"

puts"Ratings7 = #{g.ratings(8,1).text}"
puts"Value7 = #{g.ratings(8,2).text}"
puts"Unit7 = #{g.ratings(8,3).text}"
#***************************************************************************
#**********************************Branch Settings**************************
g.scroll(3).click
sleep 3
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"
#*****************************************************************************
#*********************************Branch Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"

puts"Ratings4 = #{g.ratings(5,1).text}"
puts"Value4 = #{g.ratings(5,2).text}"
puts"Unit4 = #{g.ratings(5,3).text}"

puts"Ratings5 = #{g.ratings(6,1).text}"
puts"Value5 = #{g.ratings(6,2).text}"
puts"Unit5 = #{g.ratings(6,3).text}"

puts"Ratings6 = #{g.ratings(7,1).text}"
puts"Value6 = #{g.ratings(7,2).text}"
puts"Unit6 = #{g.ratings(7,3).text}"

puts"Ratings7 = #{g.ratings(8,1).text}"
puts"Value7 = #{g.ratings(8,2).text}"
puts"Unit7 = #{g.ratings(8,3).text}"

puts"Ratings8 = #{g.ratings(9,1).text}"
puts"Value8 = #{g.ratings(9,2).text}"
puts"Unit8 = #{g.ratings(9,3).text}"

puts"Ratings9 = #{g.ratings(10,1).text}"
puts"Value9 = #{g.ratings(10,2).text}"
puts"Unit9 = #{g.ratings(10,3).text}"
=begin
#*****************************************************************************
#**********************************Receptacle Settings**************************
g.scroll(3).click
sleep 3
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"

puts"Settings4 = #{g.settings(5,1).text}"
puts"Value4 = #{g.settings(5,2).text}"
puts"Unit4 = #{g.settings(5,3).text}"
#*****************************************************************************
#*********************************Receptacle Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"
=end
#g.scroll(29).click
#sleep 1
g.scroll(5).click
sleep 1
g.pdu(26).click
#****************************PDU-Status********************
g.mstatus.click
puts"Status1 = #{g.status(2,1).text}"
puts"Value1 = #{g.status(2,2).text}"
puts"Unit1 = #{g.status(2,3).text}"

puts"Status2 = #{g.status(3,1).text}"
puts"Value2 = #{g.status(3,2).text}"
puts"Unit2 = #{g.status(3,3).text}"

puts"Status3 = #{g.status(4,1).text}"
puts"Value3 = #{g.status(4,2).text}"
puts"Unit3 = #{g.status(4,3).text}"

puts"Statu4 = #{g.status(5,1).text}"
puts"Value4 = #{g.status(5,2).text}"
puts"Unit4 = #{g.status(5,3).text}"

puts"Status5 = #{g.status(6,1).text}"
puts"Value5 = #{g.status(6,2).text}"
puts"Unit5 = #{g.status(6,3).text}"

puts"Status6 = #{g.status(7,1).text}"
puts"Value6 = #{g.status(7,2).text}"
puts"Unit6 = #{g.status(7,3).text}"

puts"Status7 = #{g.status(8,1).text}"
puts"Value7 = #{g.status(8,2).text}"
puts"Unit7 = #{g.status(8,3).text}"

puts"Status8 = #{g.status(9,1).text}"
puts"Value8 = #{g.status(9,2).text}"
puts"Unit8 = #{g.status(9,3).text}"
#***************************************************************************
#*********************************PDU Events******************************
g.mevents.click
puts"Event1 = #{g.events(2,2).text}"
puts"Value1 = #{g.events(2,3).text}"

puts"Event2 = #{g.events(3,2).text}"
puts"Value2 = #{g.events(3,3).text}"

puts"Event3 = #{g.events(4,2).text}"
puts"Value3 = #{g.events(4,3).text}"

puts"Event4 = #{g.events(5,2).text}"
puts"Value4 = #{g.events(5,3).text}"

puts"Event5 = #{g.events(6,2).text}"
puts"Value5 = #{g.events(6,3).text}"
#***************************************************************************
#*********************************PDU Settings******************************
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"

puts"Settings4 = #{g.settings(5,1).text}"
puts"Value4 = #{g.settings(5,2).text}"
puts"Unit4 = #{g.settings(5,3).text}"

puts"Settings5 = #{g.settings(6,1).text}"
puts"Value5 = #{g.settings(6,2).text}"
puts"Unit5 = #{g.settings(6,3).text}"

puts"Settings6 = #{g.settings(7,1).text}"
puts"Value6 = #{g.settings(7,2).text}"
puts"Unit6 = #{g.settings(7,3).text}"

puts"Settings7 = #{g.settings(8,1).text}"
puts"Value7 = #{g.settings(8,2).text}"
puts"Unit7 = #{g.settings(8,3).text}"

puts"Settings8 = #{g.settings(9,1).text}"
puts"Value8 = #{g.settings(9,2).text}"
puts"Unit8 = #{g.settings(9,3).text}"
#***************************************************************************
#*********************************PDU Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"

puts"Ratings4 = #{g.ratings(5,1).text}"
puts"Value4 = #{g.ratings(5,2).text}"
puts"Unit4 = #{g.ratings(5,3).text}"

puts"Ratings5 = #{g.ratings(6,1).text}"
puts"Value5 = #{g.ratings(6,2).text}"
puts"Unit5 = #{g.ratings(6,3).text}"

puts"Ratings6 = #{g.ratings(7,1).text}"
puts"Value6 = #{g.ratings(7,2).text}"
puts"Unit6 = #{g.ratings(7,3).text}"

puts"Ratings7 = #{g.ratings(8,1).text}"
puts"Value7 = #{g.ratings(8,2).text}"
puts"Unit7 = #{g.ratings(8,3).text}"
#***************************************************************************
#**********************************Branch Settings**************************
g.scroll(11).click
sleep 3
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"
#*****************************************************************************
#*********************************Branch Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"

puts"Ratings4 = #{g.ratings(5,1).text}"
puts"Value4 = #{g.ratings(5,2).text}"
puts"Unit4 = #{g.ratings(5,3).text}"

puts"Ratings5 = #{g.ratings(6,1).text}"
puts"Value5 = #{g.ratings(6,2).text}"
puts"Unit5 = #{g.ratings(6,3).text}"

puts"Ratings6 = #{g.ratings(7,1).text}"
puts"Value6 = #{g.ratings(7,2).text}"
puts"Unit6 = #{g.ratings(7,3).text}"

puts"Ratings7 = #{g.ratings(8,1).text}"
puts"Value7 = #{g.ratings(8,2).text}"
puts"Unit7 = #{g.ratings(8,3).text}"

puts"Ratings8 = #{g.ratings(9,1).text}"
puts"Value8 = #{g.ratings(9,2).text}"
puts"Unit8 = #{g.ratings(9,3).text}"

puts"Ratings9 = #{g.ratings(10,1).text}"
puts"Value9 = #{g.ratings(10,2).text}"
puts"Unit9 = #{g.ratings(10,3).text}"
=begin
#*****************************************************************************
#*********************************Receptacle Settings******************************
g.scroll(3).click
sleep 3
g.msettings.click
puts"Settings1 = #{g.settings(2,1).text}"
puts"Value1 = #{g.settings(2,2).text}"
puts"Unit1 = #{g.settings(2,3).text}"

puts"Settings2 = #{g.settings(3,1).text}"
puts"Value2 = #{g.settings(3,2).text}"
puts"Unit2 = #{g.settings(3,3).text}"

puts"Settings3 = #{g.settings(4,1).text}"
puts"Value3 = #{g.settings(4,2).text}"
puts"Unit3 = #{g.settings(4,3).text}"

puts"Settings4 = #{g.settings(5,1).text}"
puts"Value4 = #{g.settings(5,2).text}"
puts"Unit4 = #{g.settings(5,3).text}"
#*****************************************************************************
#*********************************Receptacle Ratings******************************
g.mratings.click
puts"Ratings1 = #{g.ratings(2,1).text}"
puts"Value1 = #{g.ratings(2,2).text}"
puts"Unit1 = #{g.ratings(2,3).text}"

puts"Ratings2 = #{g.ratings(3,1).text}"
puts"Value2 = #{g.ratings(3,2).text}"
puts"Unit2 = #{g.ratings(3,3).text}"

puts"Ratings3 = #{g.ratings(4,1).text}"
puts"Value3 = #{g.ratings(4,2).text}"
puts"Unit3 = #{g.ratings(4,3).text}"
=end