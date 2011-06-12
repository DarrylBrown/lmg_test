=begin rdoc

*Description*
  Test script teardown methods

*Variables*
    s = test start time
    f = test finish time
    roe = row number in spreadsheet 
    row = used to determine if driver or controller spreadsheet
    s_s = excel instance
      ss = spreadsheet
      wb = workbook
      ws = worksheet
=end


module  Teardown

  #
  # - format time to month-day hour:minute:second
  def fmt_time(t)
    t.strftime("%m-%d %H:%M:%S").to_s
  end


  #
  # - convert seconds to hour:minute:seconds
  def elapsed(s)
    (Time.mktime(0)+(s)).strftime("%H:%M:%S")
  end


  #
  #  - teardown driver - this function will update driver spreadsheet.
  def tear_down_d(s_s,s,f,roe)
    ss,wb,ws = s_s # spreadsheet instance
    # start, finish, and elapsed time to spreadsheet
    puts "Start:  #{ws.Range("b6")['Value'] = fmt_time(s)}"
    puts "Finish: #{ws.Range("b7")['Value'] = fmt_time(f)}"
    run_time = elapsed(f-s) # pass elapsed time in seconds
    ws.Range("b8")['Value'] = run_time.to_s
    status = ws.Range("b9")['Value'].to_s # Pass / Fail from Driver.xls
    puts "Status      = #{status}"
    wb.save
    wb.close #Close Driver spreadsheet
    if roe > 0  # called from controller
      # Connect to the controller script to update the status and time
      ss = WIN32OLE.connect('excel.Application')
      wb = ss.ActiveWorkbook #TODO Using the active workbook doesn't work here
      ws = wb.Worksheets(1)
      ws.Range("l#{roe}")['Value'] = status.to_s
      ws.Range("n#{roe}")['Value'] = run_time.to_s
      wb.save
    end  
  end

  
  #
  #  - teardown controller - this function will update controller spreadsheet.
  def tear_down_c(xl,s,f)
    ss,wb,ws = xl # spreadsheet instance
    # start, finish, and elapsed time to spreadsheet
    puts "Start:  #{ws.Range("b6")['Value'] = fmt_time(s)}"
    puts "Finish: #{ws.Range("b7")['Value'] = fmt_time(f)}"
    run_time = elapsed(f-s) # pass elapsed time in seconds
    ws.Range("b8")['Value'] = run_time.to_s
    wb.save
    wb.close #Close Controller spreadsheet
    ss.quit
    $ie.close
  end
  
   
  #   TODO consider deleting this method because it is not currently used
  #  - can be called to kill excel.exe
  def kill()
    kill_result = %x{tskill excel}
    #kill_result = system"TASKKILL /F /IM EXCEL.EXE"
  end  
end  
  
  
  
  

