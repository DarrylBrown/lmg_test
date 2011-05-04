=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  def_rd_snmpinfo_mphwebcard1

*Test_Case_Number*
  700.100.20.110 for MPHwebcard

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
  $ie.maximize 
  #Click the Messaging link in the on the left side of window
  #Login if not called from controller
  g.logn_chk(g.snmp,excel[1])
    
  row = 1
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1, execution starts at drvr_ss row 2
    
    #read email and sms Checkbox value
    sleep 1 #without this sleep, step 5 will fail
    Watir::Waiter.wait_until(10) { g.edit.exists?}
    g.edit.click
    puts " email = " + ws.Range("bc#{row}")['Value'] = g.checkbox(g.snmp_auth)
 	if g.checkbox(g.lgpmib) == 'set'
		ws.Range("bc#{row}")['Value'] = 'set'
		ws.Range("bd#{row}")['Value'] = 'set'
		ws.Range("be#{row}")['Value'] = 'set'
		else
         ws.Range("bd#{row}")['Value'] = 'clear'
		 ws.Range("be#{row}")['Value'] = 'clear'
        end
	
	 ws.Range("bg#{row}")['Value'] = g.snmp_hb.value
    
    g.save.click_no_wait
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