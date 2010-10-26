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
g.control.click
Watir::Waiter.wait_until(10) { g.pdu_exp.exists?}
g.pdu_exp.click
Watir::Waiter.wait_until(10) { g.cntrl_settg.exists?}
g.cntrl_settg.click
#sleep 3
#Watir::Waiter.wait_until(20) { g.cedit.exists?}
g.cedit.click
#For setting tab
g.pusr_lbl.set('PDU User Assigned Label')
puts"PDU User Assigned Label = #{g.pusr_lbl.value}"
g.ptag1.set('PDU Asset Tag 01')
g.ptag2.set('PDU Asset Tag 02')
g.neutovr_alrm.set('20')
g.neutovr_wrn.set('20')
g.ovr_alrm.set('20')
g.ovr_wrn.set('20')
g.low_alrm.set('20')
g.csave.click
#For commands tab
g.cntrl_cmnd.click
g.accum_en.click
g.gentest.click



  
  
  
 