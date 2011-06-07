=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  cfg_sntp

*Test_Case_Number*
  700.140.20.110

*Description*
  Validate the SNTP Configuration
     - Positive
     - Negative
     - Boundary
    
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

#Launch the Configure SNTP ruby script
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
  #Navigate to the 'Configure' tab
  g.config.click
  $ie.maximize  
  #Click the Configure SNTP link on the left side of window
  #Login if not called from controller
  g.logn_chk(g.time,excel[1])
  
  row = 1
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1 to row as execution starts at drvr_ss row 2
    sleep 5
    g.edit.click

    # Write SNTP Configuration fields
    g.timesrvr.set(ws.Range("k#{row}")['Value'].to_s)
    sync_rate = (ws.Range("l#{row}")['Value']).to_i
    puts "#{sync_rate}"
    if sync_rate == 0
      g.timesync('0').set
    else
      g.timesync('1').set
    end
    
    time_zone = (ws.Range("m#{row}")['Value']).to_s
    puts "#{time_zone}"
    time_zone = time_zone.delete'"'
    puts "#{time_zone}"
    g.timezone.select_value(time_zone)
    
    #Is there a popup expected? 
    pop = ws.Range("af#{row}")['Value'].to_s 
    puts "  pop_up value = #{pop}" unless pop == 'no'
    #sleep 1

    #If popup, handle with reset OK or reset Cancel to continue
    if (pop == "res")
      popup_txt  = g.invChar(pop)
      puts "Pop-Up text is #{popup_txt}"
      ws.Range("bk#{row}")['Value'] = popup_txt
    end
 
    if (pop == "can")
      ws.Range("bk#{row}")['Value'] = g.res_can(pop)
    end

    #If reset Cancel, do not save
    if (pop == "no")
      g.save.click_no_wait
      g.jsClick('OK')
    end
 
    #read SNTP Configuration  field values
    sleep 1
    g.edit.click
    
    t_srvr = g.timesrvr.value
    puts "#{t_srvr.nil?}"
    if t_srvr.nil? == true
     ws.Range("bc#{row}")['Value'] = 'time.nist.gov'
    else
     ws.Range("bc#{row}")['Value'] = g.timesrvr.value
    end
    
    if (g.timesync('0').checked? == true)
     ws.Range("bd#{row}")['Value'] = "0"
    else
     ws.Range("bd#{row}")['Value'] = "1"
    end  
    t_zone = g.timezone.value
    t_zone = t_zone.to_s
    puts "Time zone is #{t_zone}"
    t_zone.insert(0,'"').insert(9,'"')
    puts "Time zone is #{t_zone}"
    ws.Range("be#{row}")['Value'] = t_zone
    
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