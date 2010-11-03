$:.unshift File.dirname(__FILE__).chomp('snippets')<<'lib' # add library to path
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
sleep 1
#Watir::Waiter.wait_until(10) { g.cntrl_settg.exists?}
g.cntrl_settg.click
#sleep 3
#Watir::Waiter.wait_until(20) { g.cedit.exists?}
#***********************************PDU Control Settings****************
g.p_edit.click
#For setting tab
g.pusr_lbl.set('PDU User Assigned Label')
puts"PDU User Assigned Label = #{g.pusr_lbl.value}"
g.ptag1.set('PDU Asset Tag 01')
puts"PDU Asset Tag01 = #{g.ptag1.value}"
g.ptag2.set('PDU Asset Tag 02')
puts"PDU Asset Tag02 = #{g.ptag2.value}"
g.neutovr_alrm.set('20')
puts"Neutral Over Alarm = #{g.neutovr_alrm.value}"
g.neutovr_wrn.set('20')
puts"Neutral Over Warning = #{g.neutovr_wrn.value}"
g.ovr_alrm.set('20')
puts"Over Alarm = #{g.ovr_alrm.value}"
g.ovr_wrn.set('20')
puts"Over Warning = #{g.ovr_wrn.value}"
g.low_alrm.set('20')
puts"Low Alarm = #{g.low_alrm.value}"
g.c_save.click
#For commands tab
#g.cntrl_cmnd.click
#g.accum_en.click
#g.gentest.click
#***********************************Branch Control Settings****************
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
puts "Branch selected is #{br1}"
g.scroll(br1).click
sleep 1
Watir::Waiter.wait_until(10) { g.cntrl_settg.exists?}
g.cntrl_settg.click
g.b_edit.click  
sleep 1
g.busr_lbl.set('PDU User Assigned Label')
puts"Branch User Assigned Label = #{g.busr_lbl.value}"
g.btag1.set('PDU Asset Tag 01')
puts"Branch Asset Tag01 = #{g.btag1.value}"
g.btag2.set('PDU Asset Tag 02')  
puts"Branch Asset Tag02 = #{g.btag2.value}"
  
 