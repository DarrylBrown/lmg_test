=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  sms_messag

*Test_Case_Number*
  700.150.20.110

*Description*
  Validate the SMS Messaging Information configuration
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

#Launch the Configure SMS ruby script
#Add library file to the path
$:.unshift File.dirname(__FILE__).chomp('driver/webx')<<'lib' # add library to path
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
  #Navigate to the 'Configure’ tab
  g.config.click
  $ie.maximize  
  #Click the Configure SMS link on the left side of window
  #Login if not called from controller
  g.logn_chk(g.sms,excel[1])
  
  row = 1
  fail = 0
  while(row <= rows)
  row +=1
  puts "Test step #{row}"
    begin
    puts"Start of Normal loop"
    # add 1 to row as execution starts at drvr_ss row 2
    sleep 3
    Watir::Waiter.wait_until(10) { g.edit.exists?}
    g.edit.click
   
    # Write SMS fields
    g.sms_from.set(ws.Range("k#{row}")['Value'].to_s)
    g.sms_to.set(ws.Range("l#{row}")['Value'].to_s)
    puts "#{ws.Range("m#{row}")['Value'].to_s}"
    subj_type = ws.Range("m#{row}")['Value'].to_i
    puts "#{subj_type}"
    if subj_type == 0
      g.sms_subjecttype(0).set
    else
      g.sms_subjecttype(1).set
      g.sms_custsubj.set(ws.Range("n#{row}")['Value'].to_s)
    end
    g.sms_srvr.set(ws.Range("o#{row}")['Value'].to_s)
    g.sms_port.set(ws.Range("p#{row}")['Value'].to_s)  
    
    
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
     # g.jsClick('OK')
    end
 
    #read SMS all field values
    
    Watir::Waiter.wait_until(10) { g.edit.exists?}
    g.edit.click
    
   #Read SMS from and Emai to values
    ws.Range("bc#{row}")['Value'] = g.sms_from.value
    ws.Range("bd#{row}")['Value'] = g.sms_to.value
    
    #Read SMS Subject-Event and Subject Custom values
    if g.sms_subjecttype(0).checked? == true
      ws.Range("be#{row}")['Value'] = "0"
    elsif g.sms_subjecttype(1).checked? == true
      ws.Range("be#{row}")['Value'] = "1"
      puts "Custom Subject is #{g.sms_custsubj.nil?}"
      if g.sms_custsubj.nil? == true
        g.sms_custsubj.set('Test')
        ws.Range("bf#{row}")['Value'] = g.sms_custsubj.value
      else
        ws.Range("bf#{row}")['Value'] = g.sms_custsubj.value
      end
    end
    
    #Read SMTP Server value
    puts "SMTP Server is #{g.sms_srvr.nil?}"
    if g.sms_srvr.nil? == true
      g.sms_srvr.set('142.130.2.83')
      ws.Range("bg#{row}")['Value'] = g.sms_srvr.value
    else
      ws.Range("bg#{row}")['Value'] = g.sms_srvr.value
    end
    
    #Read Port value
    ws.Range("bh#{row}")['Value'] = g.sms_port.value
    
    g.save.click_no_wait
    #g.jsClick('OK')
    wb.Save
    
    rescue
    fail +=1
    puts "Error - #{fail} of #{row}"
    Watir.autoit.Send('{F5}')
    puts"********** rescue ***"
    sleep 2
    
    begin
      sleep 5 # wait for the previous click_no_wait process to time out before starting another 
      save.click_no_wait
      jsClick( $ie, "OK")
    rescue
      puts "**********no 'save' popup in rescue***"
    end
    
    g.config.click
    puts"Clicked on Configure Tab"
    
    begin
      g.sms.click_no_wait
      g.jsClick('OK')
      puts"**********sms popup ***"
    rescue
      puts"**********return-1 to normal loop***"
    end
    puts"**********return-2 to normal loop***"
    row = row - 1
    end
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