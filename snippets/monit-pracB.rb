require 'generic'
#require 'watir/process'
 
$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
g.monitor.click
g.pdu_exp.click
puts "Enter the PDU number"
p_du = gets.chomp
puts "PDU: #{p_du}"
puts "Datatype = #{p_du.kind_of? String}"
p_du = p_du.to_s
case p_du
when '1' 
 pd1 = 2
 puts "#{pd1}"
when '2' 
 pd1 = 10
when '3' 
 pd1 = 18
when '4' 
 pd1 = 26
end
puts "PDU selected is #{pd1}"
g.pdu(pd1).click

#****************************PDU-Status********************
g.m_status.click
n = 1
while n < 9
  puts"Status#{n} = #{g.status(n+1,1).text}"
  puts"Value#{n} = #{g.status(n+1,2).text}"
  puts"Unit#{n} = #{g.status(n+1,3).text}"
  n += 1
end

#***************************************************************************
#*********************************PDU Events******************************
g.m_events.click
n = 1
while n < 6
  puts"Event#{n} = #{g.events(n+1,1).text}"
  puts"Value#{n} = #{g.events(n+1,2).text}"
  n += 1
end

#***************************************************************************
#*********************************PDU Settings******************************
g.m_settings.click
n = 1
while n < 9
  puts"Setting#{n} = #{g.settings(n+1,1).text}"
  puts"Value#{n} = #{g.settings(n+1,2).text}"
  puts"Unit#{n} = #{g.settings(n+1,3).text}"
  n += 1
end

#***************************************************************************
#*********************************PDU Ratings******************************
g.m_ratings.click
n = 1
while n < 8
  puts"Ratings#{n} = #{g.ratings(n+1,1).text}"
  puts"Value#{n} = #{g.ratings(n+1,2).text}"
  puts"Unit#{n} = #{g.ratings(n+1,3).text}"
  n += 1
end

#***************************************************************************
#**********************************Branch Settings**************************

case p_du
when '1' 
br_scrl = 3
when '2' 
br_scrl = 11
when '3' 
br_scrl = 19
when '4' 
br_scrl = 27
end
puts "Branch srolled to :-#{br_scrl}"
g.scroll(br_scrl).click
sleep 1
puts"Enter the branch"
br_nch = gets.chomp
br_nch = br_nch.to_s
case br_nch
when '1' 
br1 = 2
when '2' 
br1 = 5
when '3' 
br1 = 8
end
puts "branch selected is #{br1}"
g.scroll(br1).click
sleep 1
g.m_settings.click
n = 1
while n < 4
  puts"Settings#{n} = #{g.settings(n+1,1).text}"
  puts"Value#{n} = #{g.settings(n+1,2).text}"
  puts"Unit#{n} = #{g.settings(n+1,3).text}"
  n += 1
end

#*****************************************************************************
#*********************************Branch Ratings******************************
g.m_ratings.click
n = 1
while n < 10
  puts"Ratings#{n} = #{g.ratings(n+1,1).text}"
  puts"Value#{n} = #{g.ratings(n+1,2).text}"
  puts"Unit#{n} = #{g.ratings(n+1,3).text}"
  n += 1
end

=begin
#*****************************************************************************
#**********************************Receptacle Settings**************************
puts" Enter the branch to receptacle"
rcp = gets.chomp
rcp = rcp.to_s
case rcp
when '1' 
br = 3
when '2' 
br = 6
when '3' 
br = 9
end
g.scroll(br).click
sleep 1

puts"Enter the receptacle no:"
r_cp = gets.chomp
case r_cp
when '1' 
recep = 2
when '2' 
recep = 5
when '3' 
recep = 8
when '4' 
recep = 11
when '5' 
recep = 14
when '6' 
recep = 17
when '7' 
recep = 20
when '8'
recep = 23
when '9'
recep = 26
end
g.scroll(recep).click
sleep 1
g.m_settings.click
n = 1
while n < 5
  puts"Setting#{n} = #{g.settings(n+1,1).text}"
  puts"Value#{n} = #{g.settings(n+1,2).text}"
  puts"Unit#{n} = #{g.settings(n+1,3).text}"
  n += 1
end

#*****************************************************************************
#*********************************Receptacle Ratings******************************
g.m_ratings.click
n = 1
while n < 4
  puts"Ratings#{n} = #{g.ratings(n+1,1).text}"
  puts"Value#{n} = #{g.ratings(n+1,2).text}"
  puts"Unit#{n} = #{g.ratings(n+1,3).text}"
  n += 1
end
=end
