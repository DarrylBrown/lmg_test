=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  def_wrt_snmp_trapsinfo

*Test_Case_Number*
  700.120.20.110

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
$:.unshift File.dirname(__FILE__).chomp('driver')<<'lib' # add library to path
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
  g.logn_chk(g.traps,excel[1])
  
   #Clear all rows of any contents in traps table
   g.edit.click
   for i  in 1..20
	  #puts i
      g.trap_clr(i).click
	  g.trap_hb(i).clear  # clear heartbeat traps entries
   end  
    g.save.click
	
  row = 1
  while(row <= rows)
 
    puts "Test step #{row}"
    row +=1 # add 1, execution starts at drvr_ss row 2
    sleep 2
    Watir::Waiter.wait_until(10) { g.edit.exists?}
    g.edit.click
		
	# write traps table entries
	g.trap_addr(1).set((ws.Range("k#{row}")['Value']).to_s)
	puts "Network Name=#{(ws.Range("k#{row}")['Value'])}"
	port1=ws.Range("l#{row}")['Value']
	port1 = (port1.to_i).to_s
	#puts "port Number =#{port1} "
    g.trap_port(1).set(port1)
	g.trap_com(1).set((ws.Range("m#{row}")['Value']).to_s)
	
	if ws.Range("n#{row}")['Value'] == 'set' then g.trap_hb(1).set else g.trap_hb(1).clear end
	    
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