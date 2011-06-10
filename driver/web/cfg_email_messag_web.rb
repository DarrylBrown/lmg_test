=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  email_messag

*Test_Case_Number*
  700.140.20.110

*Description*
  Validate the Email Messaging Information configuration
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

#Launch the Configure Email ruby script
#Add library file to the path
$:.unshift File.dirname(__FILE__).chomp('driver/web')<<'lib' # add library to path
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

  #TODO - these ss formatting commands will be move to setup method in the future
  ws.Columns("A:B").HorizontalAlignment = 2                   # Left Align text
  ws.Rows("2:#{rows + 1}").RowHeight = 12.75                  # Set row height

  $ie.speed = :zippy
  g.config.click
  $ie.maximize
  #Click the Configure Email link on the left side of window
  #Login if not called from controller
  g.logn_chk(g.email,excel[1])

  #Enable email on msging page first.
  g.msg_ctrl("email", "set")
  row = 1
  fail = 0
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1 to row as execution starts at drvr_ss row 2

    
    # ***** write email fields ****
    g.edit.click
    g.email_from.set(ws.Range("k#{row}")['Value'].to_s)         # From
    g.email_to.set(ws.Range("l#{row}")['Value'].to_s)           # To
    subj_type = ws.Range("m#{row}")['Value'].to_i               # Subject Type
    if subj_type == 0
      g.email_subjectttype(0).set
    else
      g.email_subjectttype(1).set
      g.email_custsubj.set(ws.Range("n#{row}")['Value'].to_s)   # Custom Subject
    end
    g.email_srvr.set(ws.Range("o#{row}")['Value'].to_s)         # Server
    g.email_port.set(ws.Range("p#{row}")['Value'].to_s)         # Port

    # popup expected?
    pop = ws.Range("af#{row}")['Value'].to_s                    
    if (pop == "res")                                           # Reset                 
      ws.Range("bi#{row}")['Value'] = g.invChar(pop)    # popup text
    end
    #TODO this will need to be cleaned up. Simple reset should not use "pop" variable
    if (pop == "reset")                                         # Reset only (no popup)
      g.reset.click_no_wait
      g.jsClick("OK")
    end
    if (pop == "can")                                           # Cancel
      ws.Range("bi#{row}")['Value'] = g.res_can(pop)
    end
    if (pop == "no")                                            # save only if no popup
      g.save.click
    end


    #**** read email fields ****
    sleep 1 #sleep 1 is need to make sure no intermittent failing
    ws.Range("bc#{row}")['Value'] = g.email_from.value          # From
    ws.Range("bd#{row}")['Value'] = g.email_to.value            # To
    if g.email_subjectttype(0).checked? == true                 # Subject Type
      ws.Range("be#{row}")['Value'] = "0"
    else
      ws.Range("be#{row}")['Value'] = "1"
      ws.Range("bf#{row}")['Value'] = g.email_custsubj.value    # Custom Subject
    end  
    ws.Range("bg#{row}")['Value'] = g.email_srvr.value          # Server
    ws.Range("bh#{row}")['Value'] = g.email_port.value          # Port

    wb.Save
  end

  f = Time.now  #finish time
#Capture error if any in the script  
rescue Exception => e
  f = Time.now  #finish time 
  puts" \n\n **********\n\n #{$@ } \n\n #{e} \n\n ***"
  error_present=$@.to_s

ensure #this section is executed even if script goes in error
  #Disable email on msging page.
  g.msg_ctrl("email", "clear")
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