=begin
#-------------------------------------------------------------------#
27-Feb-2011
This snippet is designed to demonstrate and test recovery mechanisms
for the web card. On occasion the script seems to get lost at various
points. Various rescue statements are used to restore script execution.

Rescue / Retry mechanisms have been added to the edit, save, and cfg-tab methods

This script is in sync with: IS-WEBCARD_HID6_3.100.2_057437
#-------------------------------------------------------------------#
=end

$:.unshift File.dirname(__FILE__) unless
$:.include? File.dirname(__FILE__)

require 'watir/ie'
require 'watir\contrib\enabled_popup'

def modal(pop_name,button) # modal alert popup thread
  Thread.new{
    sleep 1 # This sleep is critical, timing may need to be adjusted
    Watir.autoit.WinWait(pop_name)
    Watir.autoit.ControlClick(pop_name,"",button)
    #puts " Modal Alert popup completed"
  }
end


def fastLogin(test_site,user,pswd) # thread based method
  conn_to = $titl + test_site
  Thread.new{
    #puts" #{conn_to}, \n #{user}, \n #{pswd}"
    sleep 2 #This sleep is critical, may need to be adjusted
    Watir.autoit.WinWait(conn_to)
    Watir.autoit.WinActivate(conn_to)
    Watir.autoit.Send(user)
    Watir.autoit.Send('{TAB}')
    Watir.autoit.Send(pswd)
    modal('Windows Internet Explorer',$ok) #launch thread to handle modal popup
    Watir.autoit.Send('{ENTER}')
    puts "Login completed"
  }
end


def jsClick( a, button, user_input=nil)# java script popup method
  waitTime = 10
  begin
    hwnd = $ie.enabled_popup(waitTime)
    if (hwnd)
      w = WinClicker.new
      if ( user_input )
        w.setTextValueForFileNameField(hwnd, "#{user_input}")
      end
      sleep (0.1)
      w.clickWindowsButton_hwnd(hwnd, "#{button}")
      w = nil
    end
  rescue Timeout::Error
    puts "there was no popup within the wait time"
  end
end

#method to retry/rescue elements.
def obj_retry(obj)
  tries = 0
  begin
    sleep 1
    yield.name#".name" is an action to cause an exception
    yield
  rescue
    tries += 1
    sleep(0.5)
    puts  "retry #{obj} #{tries}"
    if(obj=="tab")
      puts "refresh F5"
    Watir.autoit.Send('{F5}')#rescue for tab is refresh page again.
    sleep 3
    elsif(obj=="link")
     config.click#rescue for link is click config tab again.
      #else
      #do nothing for button rescue
    end
    retry if tries <= 9
    puts "retry limit reached!"
  end
end

# define the tabs

def config
  obj_retry("tab") do; $ie.frame(:index, 2).image(:id, 'imgConfigure'); end
end

# define links

def cfgweb
  obj_retry("link") do; $ie.frame(:index, 3).frame(:index, 2).link(:text => 'Web', :index => 2); end
end

# define edit,save,reset buttons
def edit
  obj_retry("button") do;  $ie.frame(:index, 3).frame(:index, 3).button(:id, 'editButton'); end
end

def save
  obj_retry("button") do; $ie.frame(:index, 3).frame(:index, 3).button(:name, 'Submit'); end
end

def reset
  $ie.frame(:index, 3).frame(:index, 3).button(:value, 'Reset')
end


# define cfg_web Controls
def cfgCtrl
  $ie.frame(:index, 3).frame(:index, 3).checkbox(:id, 'enableWebCfgCtrl')
end

def isrescue
  puts"in isrescue now..."
    config.click
    yield.click_no_wait
    sleep 1
    begin
      jsClick( $ie,  $ok )#after refreshing the page, when click link, there will be popup.
    rescue
      puts "**********no 'Security alert' popup in rescue***********"
    end
    puts "<< script recovered >>"
end

def systemos
  lang = `systeminfo`
  if lang =~ /en-us*/
    $os       = "English"
    $titl       = "Connect to "
    $ok       ="OK"
    $cancel  = "Cancel"
  elsif lang =~ /zh-cn*/
    $os        = "Chinese"
    $titl        = "连接到 "
    $ok        ="确定"
    $cancel   = "取消"
  end
  puts "This OS is #{$os}"
end

systemos()
#test_site = "126.4.202.196"
test_site="test_site"
user = 'Liebert'
pswd = 'Liebert'
conn_to = $titl + test_site
# $HIDE_IE=true
$ie = Watir::IE.new
$ie.goto test_site
$ie.maximize

puts "Start watir/webcard endurance test"
#sleep 5
start = Time.now
config.click
fastLogin(test_site,user,pswd)  # Start  login thread
cfgweb.click # click_no_wait not needed when login thread is started before hand

y,x,pass,fail = 0,0,0,0 # initialize counters
sleep(y)
while x < 1000000000000
  x +=1
  puts "Test step =#{x}"
  begin
    s = Time.now
    sleep(y)
    edit.click
    #jsClick( $ie,  $ok ) # use this sentence to generate exception and enter rescue in order to test isrescue.
    save.click_no_wait
    #sleep 1  # need to remove this sleep to see what the effect is
    jsClick( $ie,  $ok )
    f = Time.now
    t = (f-s)
    pass +=1
  rescue Exception => e
    puts "Error counts is: #{fail += 1} of #{x}"
    puts " \n ***\n #{$@ } \n #{e} \n ***"
    isrescue do; cfgweb;end
    x -= 1
  end   
end

done = Time.now
total = (done-start)
puts "Total time = #{total}"
$ie.close

