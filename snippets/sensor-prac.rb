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
site = 10.130.92.34
uname = 'Liebert'
paswd = 'Liebert'
g.sensr.click
g.control.click
login(site,uname,paswd)


#***********************Relative Humidity Test***************
g.snsrid(2 -  1).click  #Relative Humidity
g.cedit.click
g.husrlbl.set('Humidity1')
g.hasstag1.set('H-tag1')
g.hasstag2.set('H-tag2')
g.hovralrm.set('60')
g.hovrwrng.set('55')
g.hundralrm.set('50')
g.hundrwrng.set('45')
g.csave.click

#******************Temperature Test*******************
g.snsrid(	2 -  2).click  #Temperature
g.cedit.click
g.tusrlbl.set('Temperature1')
g.tasstag1.set('T-tag1')
g.tasstag2.set('T-tag2')
g.tovralrm.set('60')
g.tovrwrng.set('55')
g.tundralrm.set('50')
g.tundrwrng.set('45')
g.csave.click

