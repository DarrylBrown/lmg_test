=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  custm_messag

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

  $ie.speed = :zippy
  #Navigate to the 'Configure?tab
  g.config.click
  $ie.maximize  
  #Click the Customize Messaging link on the left side of widow
  #Login if not called from controller
  g.logn_chk(g.custmsg,excel[1])
  
  row = 1
  fail = 0
  while(row <= rows)
    puts "Test step #{row}"
    row +=1 # add 1 to row as execution starts at drvr_ss row 2
    begin
    puts"Start of Normal loop"
    sleep 3
    Watir::Wait.until(10) {g.edit.exists?}
    g.edit.click

    # Write customize email and sms checkboxes
    flag = ws.Range("u#{row}")['Value'].to_s
    puts "The flag is #{flag}"
    case flag
      when 'email'
        g.email_addr.send ws.Range("k#{row}")['Value']
        g.email_evtdesc.send ws.Range("l#{row}")['Value']
        g.email_name.send ws.Range("m#{row}")['Value']
        g.email_cont.send ws.Range("n#{row}")['Value']
        g.email_loc.send ws.Range("o#{row}")['Value']
        g.email_desc.send ws.Range("p#{row}")['Value']
        g.email_weblnk.send ws.Range("q#{row}")['Value']

        g.email_consol.send ws.Range("r#{row}")['Value']
        if g.checkbox(g.email_consol)=='set'
          g.email_consoltime.set(ws.Range("s#{row}")['Value'].to_s)
          g.email_consolevt.set(ws.Range("t#{row}")['Value'].to_s)
        end
    
      when 'sms'
        g.sms_addr.send ws.Range("k#{row}")['Value']
        g.sms_evtdesc.send ws.Range("l#{row}")['Value']
        g.sms_name.send ws.Range("m#{row}")['Value']
        g.sms_cont.send ws.Range("n#{row}")['Value']
        g.sms_loc.send ws.Range("o#{row}")['Value']
        g.sms_desc.send ws.Range("p#{row}")['Value']
        g.sms_weblnk.send ws.Range("q#{row}")['Value']

        g.sms_consol.send ws.Range("r#{row}")['Value']
        if g.checkbox(g.sms_consol) == 'set'
          g.sms_consoltime.set(ws.Range("s#{row}")['Value'].to_s)
          g.sms_consolevt.set(ws.Range("t#{row}")['Value'].to_s)
        end
    end
    
    
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
 
    #read Email and SMS Checkbox value
    sleep 1
    Watir::Wait.until(10) {g.edit.exists?}
    g.edit.click
    
    case flag
      when 'email'
        ws.Range("bc#{row}")['Value'] = g.checkbox(g.email_addr)
        ws.Range("bd#{row}")['Value'] = g.checkbox(g.email_evtdesc)
        ws.Range("be#{row}")['Value'] = g.checkbox(g.email_name)
        ws.Range("bf#{row}")['Value'] = g.checkbox(g.email_cont)
        ws.Range("bg#{row}")['Value'] = g.checkbox(g.email_loc)
        ws.Range("bh#{row}")['Value'] = g.checkbox(g.email_desc)
        ws.Range("bi#{row}")['Value'] = g.checkbox(g.email_weblnk)

        ws.Range("bj#{row}")['Value'] = g.checkbox(g.email_consol)
        if g.checkbox(g.email_consol) == 'set'
          ws.Range("bl#{row}")['Value'] = g.email_consoltime.value
          ws.Range("bm#{row}")['Value'] = g.email_consolevt.value 
        end
    
      when 'sms'
        ws.Range("bc#{row}")['Value'] = g.checkbox(g.sms_addr)
        ws.Range("bd#{row}")['Value'] = g.checkbox(g.sms_evtdesc)
        ws.Range("be#{row}")['Value'] = g.checkbox(g.sms_name)
        ws.Range("bf#{row}")['Value'] = g.checkbox(g.sms_cont)
        ws.Range("bg#{row}")['Value'] = g.checkbox(g.sms_loc)
        ws.Range("bh#{row}")['Value'] = g.checkbox(g.sms_desc)
        ws.Range("bi#{row}")['Value'] = g.checkbox(g.sms_weblnk)

        ws.Range("bj#{row}")['Value'] = g.checkbox(g.sms_consol)
        if g.checkbox(g.sms_consol) == 'set'
          ws.Range("bl#{row}")['Value'] = g.sms_consoltime.value
          ws.Range("bm#{row}")['Value'] = g.sms_consolevt.value 
        end
    
    end
    
    g.save.click_no_wait
    g.jsClick('OK')
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
      g.custmsg.click_no_wait
      g.jsClick('OK')
      puts"**********email popup ***"
    rescue
      puts"**********return-1 to normal loop***"
    end
    puts"**********return-2 to normal loop***"
    row = row - 1
    next
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