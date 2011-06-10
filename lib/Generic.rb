=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Class_Name*
  Generic

*Description*
  common methods used by all scripts


Lmg_test\ruby\dd.mm.yyyy  [Core Framework]
    |
    |__lib
    |__controller
    |__driver
    |    |__telnet
    |    |__web
    |    |__webx
    |    |__rpc
    |
    |__result


=end

$:.unshift File.dirname(__FILE__) unless
$:.include? File.dirname(__FILE__)

require 'watir/ie'
require 'watir\contrib\enabled_popup' #This is called by jsClick
require 'time'
require 'win32ole'
require 'navigate'
require 'xls'
require 'setup'
require 'popup'
require 'teardown'
require 'snmp'
require 'telnet'
require 'rpc-navigate.rb'

class Generic
  include Nav
  include Xls
  include Teardown
  include Setup
  include Popup
  include Snmp
  include Telnet_cstm
  include RpcNav
 

  attr_accessor :links_array, :row_ptr
  attr_reader :num_frames, :test_site, :community_string

  def initialize
    @num_frames = 0
    @row_ptr = 2 #Start righting at row 2
    @links_array = Array.new

    #SNMP Related Class Variables
    @test_site = ''
    @community_string = ''
  end

  #
  # - used for configure information table scripts
  # - 'fw == 1' is for firmwareweb_table_info
  def table_info(start,_end,col,idx,ws,fw=nil)
    # iterate through all rows and columns
    while (start <= _end)
      j = 1
      while (j <= col)
        case j
        when 1
          if fw == 1
            parameter = param_firmwrweb(idx,start,j).text
          else
            parameter = param_descr(idx,start,j).text
          end
          ws.Range("bc#{start+1}")['Value'] =  parameter
        when 2
          if fw == 1
            description = param_firmwrweb(idx,start,j).text
          else
            description = param_descr(idx,start,j).text
          end
          ws.Range("bd#{start+1}")['Value'] = description
        end
        j += 1
      end
      start += 1
    end
  end


  #

  # - restart the card and go back to the url
  # - default count down after ping response is 50 seconds.
  def restart_wb(cnt_dn = 50)
    puts "*** restarting card ***"
    rstrt.click
    rstart.click_no_wait
    flag = false
    while flag == false
      sleep(30)
      print "pinging card - "
      ip = $ie.url.delete"http:/" #remove "http://" from url to form a pure ip
      if `ping #{ip}` =~ /Reply from/ # if ping result contains "Reply from"
        puts "successful"
        print "seconds remaining - "
        while cnt_dn > 0
          print cnt_dn,".. "
          cnt_dn -= 5
          sleep 5
        end
        flag = true
        puts"\n", "*** restart completed ***"
      else
        puts "unsuccessful"
      end
    end
    $ie.goto($ie.url)
  end


  #
  #  - read checkbox status and return set of clear
  def checkbox(box)
    if box.checked?
      'set'
    else
      'clear'
    end
  end

  #-read radio status and return radio number which selected in the table
  def radio_check(table)
    table.radios.each{|x| if x.checked? then  return  x.value end }
  end

  #  - <code>frame_idx</code> is the numerical index of the frame you want to
  #  - check for tables.
  def has_table?(frame_idx)
    str = ''
    $ie.frame(:index,frame_idx).tables.each do |t|
      str << t.to_s
    end
    return !str.empty?
  end

  #  - returns true or false if the web page under test has a frame named
  #  - <code>frame_name</code>
  def has_frame?(frame_name)
    frame_text = self.redirect {$ie.show_frames}
    !frame_text.match("#{frame_name}").nil?
  end

  #  - writes table contents in frame <code>frame_idx</code> (less header row)
  #  - to worksheet <code>ws</code>
  def table_to_ss(frame_idx, ws, report_name)
    if self.has_table?(frame_idx)
      $ie.frame(:index,frame_idx).tables.each do |table|
        if table.row_count > 1 #Header tables only have 1 row - we don't want those.
          for i in 2..table.row_count
            ws.cells(@row_ptr, 1).value = report_name.to_s #Writes the link(report)
            for j in 2..table.column_count
              if report_name =~ /\[.*\]/ and j == 2 then # Special case for multi-modules
                ws.cells(@row_ptr, j).value = table[i][j].text + " (#{report_name})"
              else
                ws.cells(@row_ptr, j).value = table[i][j].text
              end
            end
            @row_ptr += 1
          end
        end
      end
    end
  end

  #  - returns a compacted array (no nil values)
  #  - Variables
  #  - title - The textual representation of the title, will match a regex
  #  - frame_idx - numeric index of the frame in which the table of interest
  #  - belongs.
  #  - title_pos - the position in the table in which the 'title' lies.
  #  - Note that tables indices start at 1.  Ruby arrays index start at 0...
  def get_table_by_title(title,frame_idx=3,title_pos=[1,2])
    $ie.frame(:index,frame_idx).tables.each do |table|
      if table[title_pos[0]][title_pos[1]].text =~ /#{title}/
        return table.to_a.compact
      end
    end
    return nil
  end
  
  #enable and disable email and sms on the messaging page
  def msg_ctrl(type, state)
    msging.click
    edit.click
    email_msg.send state if type == "email"
    sms_msg.send state if type == "sms"
    save.click_no_wait
    jsClick("OK")
    send(type).click #Retrun back to original page.
    # Use send method to convert string, such as "email"/"sms", to existing method email/sms.
  end

  #enable and disable management protocol ,such as snmpv1v2, on the management protocol page
  def mgtprot_ctrl(state)
    mgtprot.click
    edit.click
    snmp_v1v2.send state
    save.click_no_wait
    jsClick("OK")
    snmp.click #Retrun back to original page.
  end

end

class Array
  #  - An attempt to generalize outputting an array of values to a result spread
  #  - sheet.
  #  - Variables
  #  - ws - the worksheet to write the array to
  #  - depth - for multi-dimensional arrays - think # of columns
  #  - row_start -
  #  - col_start -
  def to_spread_sheet(ws,depth=1,row_start=1,col_start=1)
    tmp = self.flatten
    tmp.each_slice(depth) do |row|
      col = col_start
      row.each do |item|
        ws.cells(row_start, col).value = item.to_s
        col +=1
      end
      row_start += 1
    end
  end
end

  # - This method can be used at the beginning of a watir script to determine
  # - if another instance of ie is running.  Typically if multiple instances of
  # - ie are running watir scripts will hang on popups.
  #TODO - is this method using tasklist sufficient or should it use wmi??
  def is_process_running?(image_name)
    puts "Looking for instances of #{image_name}"
    command = 'tasklist /FI "IMAGENAME eq ' + "#{image_name}"""
    command_output = `#{command}`
    command_output.each_line do |line|
      if line =~ /^#{image_name}/
        return true
      end
    end
    return false
  end

  # - Returns an array of process ids (pids) for a given image name using the
  # - windows tasklist command
  def get_process_pids(image_name)
    pid_array = Array.new
    command = 'tasklist /FI "IMAGENAME eq ' + "#{image_name}"""
    command_output = `#{command}`
    command_output.each_line do |line|
      if line =~ /^#{image_name}/
        pid_array << line.split(/ +/)[1]
      end
    end
    return pid_array
  end

  # - Kills processes matched in the supplied array of pids using the windows
  # - taskkill command
  def kill_processes(pid_array)
    command = 'taskkill '
    pid_array.each do |pid|
      command = command + "/pid #{pid} "
    end
    `#{command}`
  end