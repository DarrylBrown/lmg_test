require 'net/telnet'
require 'win32ole'

begin

  #Open up the driver spreadsheet and create the timestamped spreadsheet for this test
  base_ss = File.expand_path(File.dirname(__FILE__)) + '/' + 'cfg_custm_messag_tn.xls'
  new_ss = (base_ss.chomp(".xls")<<'_'<<Time.now.to_a.reverse[5..9].to_s<<(".xls")).gsub('driver/telnet','result')
  ss = WIN32OLE::new('excel.Application')
  ss.DisplayAlerts = false #Stops excel from displaying alerts
  ss.Visible = true # For debug
  wb = ss.Workbooks.Open(base_ss)
  new_ss.gsub!('/','\\')
  wb.SaveAs(new_ss)
  ws = wb.Worksheets(1)

  ip = ws.Range("B3")['Value'].to_s #Define Test Site
  login_name = ws.Range("B4")['Value'].to_s #Define Login Name
  login_password = ws.Range("B5")['Value'].to_s #Define Password
  $cr = "\x0D" # Ascii Hex code for Carriage Return is 0D

  # Spawns a separate thread and sends the ESC key until the Main Menu is encountered.
  #TODO - This should be re-written to check if it is at the main menu before sending ESC key
  def main_menu(telnet)
    esc = "\x1b"
    flag = true
    main_menu_regex = 'Main Menu'
    Thread.new {
      while flag == true
        telnet.write(esc){|c| print c}
        sleep(1)
      end
    }
    while flag == true
      telnet.waitfor('String' => main_menu_regex, 'waittime' => 1){|c| print c}
      flag = false
    end
  end

  # Waits for the device given at ip to reboot by sending pings
  #TODO - This sould be re-written to get rid of the hard sleep of 20 seconds.  Perhaps
  #wait until the device has been discovered?
  def wait_for_reboot(ip)
    puts "\n\n"
    flag = true
    reply_from = Regexp.new('Reply from')
    while flag == true
      puts "Waiting for device to reboot"
      sleep(20)
      results = `ping #{ip}`
      puts results
      if (reply_from.match(results)) then
        puts "Device is booting..."
        sleep(30)
        flag = false
      end
    end
    puts "\n\n"
  end

  # Method abstraction for logging into a ENP Intellislot card
  def login(telnet, login_name, login_password)

    #Send carriage return to bring up login in prompt
    telnet.write($cr){|c| print c}

    #Wait for login prompt
    telnet.waitfor(/[Ll]ogin[: ]*\z/) {|c| print c}

    #Send username
    telnet.cmd(login_name) {|c| print c} #Use cmd when you want to send CR, use write when you dont

    #Wait for password prompt
    telnet.waitfor(/Password[: ]*\z/) {|c| print c}

    #Send password
    telnet.cmd(login_password) {|c| print c}

  end

  #
  def input_data(telnet, ws, start_row, end_row)
    while (start_row < end_row) do
      if ws.Range("H#{start_row}")['Value'] == 'IGNORE'
        start_row += 1
        next
      end
      navigation_string = ws.Range("F#{start_row}")['Value']
      reg_ex_cr = Regexp.new('\{enter\}')
      navigation = navigation_string.split(',')
      navigation.each do |s|
        if reg_ex_cr.match(s) then
          telnet.write($cr)
          telnet.waitfor(/\?>/) {|c| print c}
          next
        end
        telnet.write(s) {|c| print c}
        ##Don't wait for a new prompt if telnet is waiting for a carriage return - forgive the disgusting syntax...
        if (reg_ex_cr.match(navigation[navigation.rindex(s)+1]) or reg_ex_cr.match(navigation[navigation.size-2])) then next; end;
        telnet.waitfor(/\?>|Hit/) {|c| print c} # The Hit is for the "Hit any key prompts..."
      end

      command_string = ws.Range("G#{start_row}")['Value'].to_s
      command = command_string.split(',')
      if command_string =~ /enter/ then
        command.each do |s|
          puts "\nCommand String is: #{s}\n"
          if reg_ex_cr.match(s) then
            puts 'We got an enter up in here!';
            telnet.write($cr)
            telnet.waitfor(/\?>|Hit/) {|c| print c}
            next
          end
          telnet.write(s.to_s) {|c| print c}
        end
      else
        command.each do |s|
          puts "\nCommand String is: #{s}\n"
          telnet.write(s) {|c| print c}
        end
      end
	  
      main_menu(telnet) #Go back to the main menu
      start_row += 1
    end
  end

  #
  def verify_data(telnet,ws, start_row, end_row)
    while (start_row < end_row) do
      if ws.Range("H#{start_row}")['Value'] == nil or ws.Range("H#{start_row}")['Value'] == 'IGNORE' then
        puts "\nExpected a value at H#{start_row} for test #{ws.Range("E#{start_row}")['Value']} skipping this verification..."
        start_row += 1
        next
      end

      navigation_string = ws.Range("F#{start_row}")['Value']
      reg_ex_data_label = Regexp.new(ws.Range("H#{start_row}")['Value'])
      reg_ex_cr = Regexp.new('\{enter\}')
      navigation = navigation_string.split(',')

      navigation.each do |s|
        buffer = ''
        #if ws.Range("J#{start_row}")['Value'] != nil then puts "Broken!"; break; end; #Not sure why this is here.
        if reg_ex_cr.match(s) then
          telnet.write($cr)
          telnet.waitfor(/\?>/) {|c| print c; buffer += c;}
          next
        end
        telnet.write(s) {|c| print c}
        ##Don't wait for a new prompt if telnet is waiting for a carriage return - forgive the disgusting syntax...
        #if (reg_ex_cr.match(navigation[navigation.rindex(s)+1]) or reg_ex_cr.match(navigation[navigation.size-2])) then next; end;
        telnet.waitfor(/\?>/) {|c| print c; buffer += c;}
        buffer.each_line do |line|
          if (reg_ex_data_label.match(line)) then
            actual_value = ''
            line = line.sub!(reg_ex_data_label, '')
            line = line.split(" ")
            0.upto(line.size-1) { |i| actual_value << line[i] << " " }
            ws.Range("J#{start_row}")['Value'] = actual_value.chomp(" ")
          end
        end
      end

      #Go back to the main menu
      main_menu(telnet)
      start_row += 1
    end
  end

  # Returns an array containing the row numbers in which a reboot must occur
  def identify_reboots(ws, column='F', reboot=/REBOOT/i)
    xldown = -4121 #Constant used by excel
    total_rows = ws.Range("#{column}:#{column}").End(xldown).row
    reboots = Array.new
    for row in 2..total_rows
      if ws.Range("#{column}#{row}").Value =~ reboot
        reboots << row
      end
    end
    reboots
  end

  # Attempts to reboot (by sending an 'x') at the current menu
  def reboot(telnet)
    telnet.cmd('x') {|c| print c}
  end

  puts"Open telnet connection to device"

  #regex to match prompt
  prompt=/[:>]*/n
  telnet = Net::Telnet.new('Host' => ip, 'Prompt' => prompt, "Output_log" => "data_input_log.txt")

  login(telnet, login_name, login_password)
  telnet.waitfor(/\?>/) {|c| print c}

  # Read in the number of rows to execute
  rows = ws.Range("B2")['Value']

  # Start at row 2
  current_row = 2
  total_rows = current_row + rows.to_i

  # Identify reboots in 'Navigation' column
  reboots = identify_reboots(ws, 'F')

  #Input data and verify after each reboot
  reboots.each do |reboot_row|
    input_data(telnet, ws, current_row, reboot_row)
    reboot(telnet)
    wait_for_reboot(ip)
    telnet = Net::Telnet.new('Host' => ip,'Prompt' => prompt, "Output_log" => "data_verification_log.txt")
    login(telnet, login_name, login_password)
    verify_data(telnet, ws, current_row, reboot_row)
    current_row = reboot_row + 1
  end

  if reboots.size == 0
    input_data(telnet, ws, current_row, total_rows)
    reboot(telnet)
    wait_for_reboot(ip)
    telnet = Net::Telnet.new('Host' => ip,'Prompt' => prompt , "Output_log" => "data_verification_log.txt")
    login(telnet, login_name, login_password)
    verify_data(telnet, ws, current_row, total_rows)
  end

  puts "\n\nTest complete!\nStatus is #{ws.Range("B16")['Value']}"
rescue Exception => e
  puts "Script failed on row: #{current_row}"
  puts $@.to_s #Array of backtrace
  puts $! #Exception Information
ensure
  wb.save
  wb.close
  ss.quit
end