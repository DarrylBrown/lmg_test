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
  # - start, finish, and elapsed time to console and spreadsheet
  def run_time(s,f,ws)
    puts "Start:  #{ws.Range("b6")['Value'] = fmt_time(s)}"
    puts "Finish: #{ws.Range("b7")['Value'] = fmt_time(f)}"
    ws.Range("b8")['Value'] = elapsed(f-s)
  end


  #
  # - teardown driver - this function will update driver spreadsheet
  # - update controller spreadsheet if called from controller
  def tear_down_d(xl,s,f,roe)
    ss,wb,ws = xl # spreadsheet
    elapsed = run_time(s,f,ws)
    status = ws.Range("b9")['Value'] # driver Pass / Fail
    puts "Status: #{status}\n\n"
    wb.save
    wb.close

    # write driver status and time to controller spreadsheet
    if roe > 0  
      ss = WIN32OLE.connect('excel.Application')
      wb = ss.ActiveWorkbook #TODO Using the active workbook doesn't work here
      ws = wb.Worksheets(1)
      ws.Range("l#{roe}")['Value'] = status
      ws.Range("n#{roe}")['Value'] = elapsed
      wb.save
    end  
  end

  
  #
  # - teardown controller - this function will update controller spreadsheet.
  def tear_down_c(xl,s,f)
    ss,wb,ws = xl # spreadsheet
    run_time(s,f,ws)
    wb.save
    wb.close 
    ss.quit
    $ie.close
  end

   
  #   TODO consider deleting this method because it is not currently used
  # - can be called to kill excel.exe
  def kill()
    kill_result = %x{tskill excel}
    #kill_result = system"TASKKILL /F /IM EXCEL.EXE"
  end  
end  
  
  
  
  

