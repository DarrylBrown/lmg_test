=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  cfg_telnet_info3.rb

*Test_Case_Number*
  700.010.20.110

*Description*
  Validate the Messaging Information configuration
     Select
     - Deselect
     - Reset Ok and Reset Cancel

*Variable_Definitions*
    s = test start time
    f = test finish time
    e = test elapsed time
    roe = row number in controller spreadsheet
    excel = nested array that contains an instance of excel and driver parameters
    ss = spreadsheet
    wb = workbook
    ws = worksheet
    dvr_ss = driver spreadsheet
    rows = number of rows in spreadsheet to execute
    site = url/ip address of card being tested
    name = user name for login
    pswd = password for login

=end

#Launch the Messaging ruby script
#Add library file to the path
$:.unshift File.dirname(__FILE__).chomp('driver/rpc')<<'lib' # add library to path
s = Time.now
require 'generic'
require 'watir/process'

begin 
  puts" \n Executing: #{(__FILE__)}\n\n" # print current filename
  g = Generic.new
  roe = ARGV[1].to_i
  #Open up a new excel instance and save it with the timestamp.
  #Open the IE browser
  #Collect the support page information and save it in the time stamped spreadsheet.
  excel = g.setup(__FILE__)
  wb,ws = excel[0][1,2]
  rows = excel[1][1] 

  $ie.speed = :zippy
  #Navigate to the ?Configure? tab
  g.config.click
  #Click the Messaging link in the on the left side of window
  $ie.maximize()
  #Login if not called from controller
  g.logn_chk(g.telnet,excel[1])
    
  row = 1
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1, execution starts at drvr_ss row 2
    sleep 3
    Watir::Waiter.wait_until(5) { g.edit.exists?}
    g.edit.click

    # write telnet checkbox value
    if ws.Range("k#{row}")['Value'] == 'set' then g.telnet1.set else g.telnet1.clear end
   
    # if a popup is expected, handle with Reset-OK or Reset-Cancel
    # if no popup is expected, save
    pop = ws.Range("af#{row}")['Value']
    unless pop == "no"
      ws.Range("bk#{row}")['Value'] = g.res_can(pop)
    else
      g.save.click_no_wait
      g.jsClick('Windows Internet Explorer', 'OK')
    end

    #read email and sms Checkbox value
    sleep 1 #without this sleep, step 5 will fail
    Watir::Waiter.wait_until(5) { g.edit.exists?}
    g.edit.click
    puts "telnet ="+ws.Range("bc#{row}")['Value'] = g.checkbox(g.telnet1) 
    g.save.click_no_wait
    g.jsClick('Windows Internet Explorer', 'OK')

    wb.Save
  end

  f = Time.now  #finish time
#Capture error if any in the script  
rescue Exception => e
  f = Time.now  #finish time 
  puts" \n\n **********\n\n #{$@ } \n\n #{e} \n\n ***"
  error_present=$@.to_s

ensure #this section is executed even if script goes in error
  if(error_present == nil)
    # If roe > 0, script is called from controller
    # If roe = 0, script is being ran independently
    #Close and save the spreadsheet and the web browser.
    g.tear_down_d(excel[0],s,f,roe)
    if roe == 0
      $ie.close
    end
  else 
    puts" There were errors in the script"
    status = "script in error"
    wb.save
    wb.close
  end
end