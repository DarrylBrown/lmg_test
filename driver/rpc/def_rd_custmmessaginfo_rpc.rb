=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  cfg_rd_custmmessaginfo1

*Test_Case_Number*
  700.160.20.110

*Description*
  Validate the Customize Messaging Information configuration
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

#Launch the Customize Messaging ruby script
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
  #Navigate to the 'Configure� tab
  g.config.click
  $ie.maximize  
  #Click the Customize Messaging link on the left side of widow
  #Login if not called from controller
  g.logn_chk(g.custmsg,excel[1])
  
  row = 1
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1 to row as execution starts at drvr_ss row 2
     
    #read Email and SMS Checkbox value
    sleep 1
    Watir::Waiter.wait_until(10) { g.edit.exists?}
    g.edit.click
	
    flag = ws.Range("u#{row}")['Value'].to_s
    puts "The flag is #{flag}"
    case flag
      when 'email'
        if g.checkbox(g.email_addr) == 'set' then ws.Range("bc#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_evtdesc) == 'set' then ws.Range("bd#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_name) == 'set' then ws.Range("be#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_cont) == 'set' then ws.Range("bf#{row}")['Value'] = 'set' else ws.Range("bf#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_loc) == 'set' then ws.Range("bg#{row}")['Value'] = 'set' else ws.Range("bg#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_desc) == 'set' then ws.Range("bh#{row}")['Value'] = 'set' else ws.Range("bh#{row}")['Value'] = 'clear' end
        if g.checkbox(g.email_weblnk) == 'set' then ws.Range("bi#{row}")['Value'] = 'set' else ws.Range("bi#{row}")['Value'] = 'clear' end
    
        if g.checkbox(g.email_consol) == 'set'
          ws.Range("bj#{row}")['Value'] = 'set'
          ws.Range("bl#{row}")['Value'] = g.email_consoltime.value
          ws.Range("bm#{row}")['Value'] = g.email_consolevt.value 
        else
          ws.Range("bj#{row}")['Value'] = 'clear'
        end
    
      when 'sms'
        if g.checkbox(g.sms_addr) == 'set' then ws.Range("bc#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_evtdesc) == 'set' then ws.Range("bd#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_name) == 'set' then ws.Range("be#{row}")['Value'] = 'set' else ws.Range("be#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_cont) == 'set' then ws.Range("bf#{row}")['Value'] = 'set' else ws.Range("bf#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_loc) == 'set' then ws.Range("bg#{row}")['Value'] = 'set' else ws.Range("bg#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_desc) == 'set' then ws.Range("bh#{row}")['Value'] = 'set' else ws.Range("bh#{row}")['Value'] = 'clear' end
        if g.checkbox(g.sms_weblnk) == 'set' then ws.Range("bi#{row}")['Value'] = 'set' else ws.Range("bi#{row}")['Value'] = 'clear' end
    
        if g.checkbox(g.sms_consol) == 'set'
          ws.Range("bj#{row}")['Value'] = 'set'
          ws.Range("bl#{row}")['Value'] = g.sms_consoltime.value
          ws.Range("bm#{row}")['Value'] = g.sms_consolevt.value 
        else
          ws.Range("bj#{row}")['Value'] = 'clear'
        end
    
    end
    
    g.save.click_no_wait
    g.jsClick('OK')
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
    #Close and save the spreadsheet and thes web browser.
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