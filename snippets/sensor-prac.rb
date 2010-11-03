$:.unshift File.dirname(__FILE__).chomp('snippets')<<'lib' # add library to path
require 'generic'
require 'watir/process'
 
require 'generic'
require 'watir/process'
 
def login(site,user,pswd)
    conn_to = 'Connect to '+ site
    Thread.new{
      thread_cnt = Thread.list.size
      sleep 1 #This sleep is critical, timing may need to be adjusted
      Watir.autoit.WinWait(conn_to)
      Watir.autoit.WinActivate(conn_to)
      Watir.autoit.Send(user)
      Watir.autoit.Send('{TAB}')
      Watir.autoit.Send(pswd)
      popup('Windows Internet Explorer','OK') #launch thread for alert popup
      Watir.autoit.Send('{ENTER}')
    }
  end 
  
def popup(name,btn) #alert popup thread
    Thread.new{
      sleep 1 # This sleep is critical, timing may need to be adjusted
      Watir.autoit.WinWait(name)
      Watir.autoit.ControlClick(name,"",btn)
    }
  end  
 
$ie = Watir::IE.new
$ie.goto('http://10.130.92.34')
$ie.maximize
g = Generic.new
site = '10.130.92.34'
uname = 'Liebert'
paswd = 'Liebert'
g.control.click_no_wait
login(site,uname,paswd)
g.sensr.click
g.sensr.click
#***********************Relative Humidity Test***************
sleep 3
id = "2 -  1"
id = id.to_s
g.sensrid(id).click  #Relative Humidity
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '2 -  1').click
g.s_edit.click

g.h_usrlbl.set('Humidity1')
g.h_asstag1.set('H-tag1')
g.h_asstag2.set('H-tag2')
g.h_ovralrm.set('27')
g.h_ovrwrng.set('25')
g.h_undralrm.set('21')
g.h_undrwrng.set('23')

g.c_save.click
g.s_edit.click

puts"Humidity user label = #{g.h_usrlbl.value}"
puts"Humidity asset tag01 = #{g.h_asstag1.value}"
puts"Humidity asset tag02 = #{g.h_asstag2.value}"
puts"Humidity Over Alarm = #{g.h_ovralrm.value}"
puts"Humidity Over Warning = #{g.h_ovrwrng.value}"
puts"Humidity Under Alarm = #{g.h_undralrm.value}"
puts"Humidity Under Warning = #{g.h_undrwrng.value}"

g.c_save.click
#******************Temperature Test*******************
id =  "2 -  2"
id = id.to_s
g.sensrid(id).click  #Temperature
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '2 -  2').click
g.s_edit.click
g.t_usrlbl.set('Temperature1')
g.t_asstag1.set('T-tag1')
g.t_asstag2.set('T-tag2')
g.t_ovralrm.set('27')
g.t_ovrwrng.set('25')
g.t_undralrm.set('21')
g.t_undrwrng.set('23')

g.c_save.click
g.s_edit.click

puts"Temperature user label = #{g.t_usrlbl.value}"
puts"Temperature asset tag01 = #{g.t_asstag1.value}"
puts"Temperature asset tag02 = #{g.t_asstag2.value}"
puts"Temperature Over Alarm = #{g.t_ovralrm.value}"
puts"Temperature Over Warning = #{g.t_ovrwrng.value}"
puts"Temperature Under Alarm = #{g.t_undralrm.value}"
puts"Temperature Under Warning = #{g.t_undrwrng.value}"

g.c_save.click
#**************************Door Closure Test**************
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '3 -  1-1').click
id = "3 -  1-1"
id = id.to_s
g.sensrid(id).click
g.s_edit.click
g.d_usrlbl.set('6E0000000DDFC620-1')
g.d_asstag1.set('DoorTag01')
g.d_asstag2.set('DoorTag02')
g.d_alrmcnfg('1').set

g.c_save.click
g.s_edit.click

puts"Door Closure label = #{g.d_usrlbl.value}"
puts"Door Closure asset tag01 = #{g.d_asstag1.value}"
puts"Door Closure asset tag02 = #{g.d_asstag2.value}"
#puts"Door Closure Alarm config =#{g.d_alrmcnfg.value}"

g.c_save.click
#**************************Contact Closure Test**************
#$ie.frame(:index, 3).frame(:index, 3).link(:text, '4 -  1-1').click
id = "4 -  1-1"
id = id.to_s
g.sensrid(id).click
g.s_edit.click
g.c_usrlbl.set('100000000DD2E920-1')
g.c_asstag1.set('ContactClosure Asset Tag 01')
g.c_asstag2.set('ContactClosure Asset Tag 02')
g.c_alrmcnfg('1').set

g.c_save.click
g.s_edit.click

puts"Contact Closure label = #{g.c_usrlbl.value}"
puts"Contact Closure asset tag01 = #{g.c_asstag1.value}"
puts"Contact Closure asset tag02 = #{g.c_asstag2.value}"
#puts"Contact Closure Alarm config = #{g.c_alrmcnfg.value}"

g.c_save.click

