=begin

*Description*
  The controller is used to run suites of driver scripts.

*Variables*
    s = test start time
    f = test finish time
    excel = nested array that contains an instance of excel and script parameters
      excel[0] = excel instance
        ss = spreadsheet[0]
        wb = workbook[1]
        ws = worksheet[2]
      excel[1] = parameters
        ctrl_ss = controller spreadsheet[0]
        rows = number of rows in spreadsheet to execute[1]
        site = url/ip address of card being tested[2]
        name = user name for login[3]
        pswd = password for login[4]
    row = incremented each cycle, indicates the row that is being executed
    rows = number of spreadsheet rows to iterate ; cell 'B2'
    r_ow = Sequential number of script located in the controller spreadsheet
    run_flag = determines if script in row will run based on check in column 'D'

TODO driver log files are currently disabled
=end

$:.unshift File.dirname(__FILE__).sub('controller','lib') #add lib to load path
require 'generic'
s = Time.now

begin
  puts" \n Executing: #{(__FILE__)}\n\n" #current file
  g = Generic.new
  
  setup = g.setup(__FILE__)
  xl = setup[0]
  ws = xl[2] # spreadsheet
  ctrl_ss,rows,site,name,pswd = setup[1]

  # login now so drivers won't have to
  g.config.click    
  g.login(site,name,pswd)
  g.equipinfo.click
 
  row  = 1
  while (row <= rows)
    row += 1
    # run driver if the 'run' box is checked
    if ws.Range("e#{row}")['Value'] == true
      print" Run driver script #{row - 1} -- "
      path = File.expand_path('driver')
      drvr = path << (ws.Range("j#{row}")['Value'].to_s) # driver path
      t = Time.now.strftime("%m%d%H%M%S")
      log = (drvr.gsub('.rb',"-#{t}.log" )).sub('driver','result')
      system "ruby #{drvr} #{ctrl_ss} #{row}"# > {log}" # run driver
      g.conn_act_xls # reconnect to controller spreadsheet
    end
  end
  f = Time.now  
  g.tear_down_c(xl,s,f)
  
rescue Exception => e
  puts" \n\n **********\n\n #{$@ } \n\n #{e} \n\n ***"
end