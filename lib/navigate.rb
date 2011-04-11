=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Module_Name*
  Navigate

*Description*
  Object repository for:
    - navigation tabs
    - navigation links
    - buttons
    - radio buttons
    - tables
    - text fields

*Variables*

=end


module Nav

  #method to retry/rescue elements.
  def obj_retry(obj)
    tries = 0
    begin
      sleep 1
      yield.name#".name" is an action to cause an exception
      yield
    rescue
      tries += 1
      sleep(0.5)
      puts  "retry #{obj} #{tries}"
      if(obj=="tab")
        puts "refresh F5"
        Watir.autoit.Send('{F5}')#rescue for tab is refresh page again.
        sleep 3
      elsif(obj=="link")
        config.click#rescue for link is click config tab again.
        #else
        #do nothing for button rescue
      end
      retry if tries <= 9
      puts "retry limit reached!"
    end
  end

  #  - Tab area frameset abstration
  def tab
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /tabArea/ then $ie.frame(:name, 'tabArea')
    else $ie
    end
  end

  # - monitor tab link
  def monitor; tab.image(:name, 'imgMonitor'); end
  # - control tab link
  def control; tab.image(:id, 'imgControl'); end
  # - config tab link
  #def config; tab.image(:id, 'imgConfigure'); end
  def config
    obj_retry("tab") do; tab.image(:id, 'imgConfigure'); end
  end
  # - event log tab link
  def evtlog; tab.image(:id, 'imgEventLog'); end
  # - data logs tab link
  def datalogs; tab.image(:id, 'imgDatalogs'); end
  # - support tab link
  def supp
    obj_retry("tab") do; tab.image(:id, 'imgSupport'); end
  end



  # - Navigation link frameset abstration
  def nav
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /infoArea/ then $ie.frame(:name, 'infoArea').frame(:name, 'navTreeArea')
    else $ie.frame(:id, 'navigationFrame')
    end
  end

  # - Equipment / Agent Information navigation link.
  def equipinfo
    obj_retry("link") do
      if nav.link(:text, 'Equipment Information').exists?
        nav.link(:text, 'Equipment Information')
      else
        nav.link(:text, 'Agent Information')
      end
    end
  end
  # - Factory Defaults configuration link
  def factdef; nav.link(:text, 'Factory Defaults'); end
  # - Firmware Update configuration link
  def fwupdt; nav.link(:text, 'Firmware Update'); end
  # - Firmware Update Web configuration link
  def updtweb
    obj_retry("link") do; nav.link(:text, 'Web'); end
  end
  # - TFTP configuration link
  def updttftp
    obj_retry("link") do; nav.link(:text, 'TFTP'); end
  end
  # - Network Settings configuration link
  def netset
    obj_retry("link") do; nav.link(:text, 'Network Settings'); end
  end
  # - DNS configuration link
  def dns
    obj_retry("link") do; nav.link(:text, 'DNS'); end
  end
  # - DNS Test configuration link
  def dnstest
    obj_retry("link") do; nav.link(:text, 'Test'); end
  end
  # - SNTP configuration link
  def time
    obj_retry("link") do; nav.link(:text, /Time/); end
  end
  # - Management Protocol configuration link
  def mgtprot
    obj_retry("link") do; nav.link(:text, 'Management Protocol'); end
  end
  # - SNMP configuration link
  def snmp
    obj_retry("link") do; nav.link(:text, 'SNMP'); end
  end
  # - SNMP Access configuration link
  def access; nav.link(:text, 'Access'); end
  # - SNMP Traps configuration link
  def traps; nav.link(:text, 'Traps'); end
  # - SNMP V1 Access configuration link (for V3 card)
  def v1access 
    obj_retry("link") do;  nav.link(:text, 'V1 Access'); end
  end
  # - SNMP V1 Traps configuration link (for V3 card)
  def v1traps 
    obj_retry("link") do; nav.link(:text, 'V1 Traps'); end
  end
  # - SNMP V3 settings configuration link
  def snmpv3; nav.link(:text, 'V3 Settings'); end
  # - Messaging configuration link
  def msging 
    obj_retry("link") do; nav.link(:text, 'Messaging');  end
  end
  # - Email configuration link
  def email
    obj_retry("link") do; nav.link(:text, 'Email');  end
  end
  # - SMS configuration link
  def sms
    obj_retry("link") do; nav.link(:text, 'SMS');  end
  end

  # - Customize Message configuration link
  #def custmsg; nav.link(:text, 'Customize Message'); end
  def custmsg
    obj_retry("link") do; nav.link(:text, 'Customize Message');  end
  end
  # - Restart configuration link
  def rstrt; nav.link(:text, 'Restart'); end
  # - Telnet configuration link
  def telnet
    obj_retry("link")  do; nav.link(:text, 'Telnet');  end
  end
  # - Users configuration link
  def users
    obj_retry("link")do;nav.link(:text, 'Users'); end
  end
  # - Web Configuration link
  def cfgweb
    obj_retry("link")do;nav.link(:text => 'Web', :index => 2); end
  end
  # - SNMP Capabitlites - Events - Link
  def events; nav.link(:text => 'Events'); end;
  # - SNMP Capabitlites - Parameters - Link
  def parameters; nav.link(:text => 'Parameters'); end;



  # - Detail Area frameset abstraction for:
  #   - buttons
  #   - check boxes
  #   - radio button
  #   - text fields
  #   - tables
  def det
    if has_frame?('infoArea') then  $ie.frame(:name, 'infoArea').frame(:name, 'detailArea')
    else $ie.frame(:index, 3)
    end
  end


  # - Edit button
  #def edit; det.button(:id, 'editButton'); end
  def edit
    obj_retry("button") do; det.button(:id, 'editButton');  end
  end
  # - Save button
  #def save; det.button(:name, 'Submit'); end
  def save
    obj_retry("button") do; det.button(:name, 'Submit');  end
  end
  # - Reset button
=begin
  def reset
    if det.button(:value, 'Reset').exists?
      det.button(:value, 'Reset')
    else
      det.button(:value, 'Cancel')
    end
  end
=end
  def reset
    obj_retry("button") do
      if det.button(:value, 'Reset').exists?
        det.button(:value, 'Reset')
      else
        det.button(:value, 'Cancel')
      end
    end
  end
  # - Firmware Update button
  def web_updt; save; end 
  # - Restart button
  def restart1; save ; end
  # - Reset to Factory Defaults Button
  def reset_to_factory_defaults; det.button(:value, 'Reset To Factory Defaults'); end;

  # - Equipment Name text field
  def name; det.form(:name, 'configDevice').text_field(:id, 'deviceName'); end
  # - Equipment Contact text field
  def cont; det.form(:name, 'configDevice').text_field(:id, 'contact'); end
  # - Equipment Location text field
  def loc; det.form(:name, 'configDevice').text_field(:id, 'location'); end
  # - Equipment Description text field
  def desc; det.form(:name, 'configDevice').text_field(:id, 'description'); end


  # - Equipment Name in Support page table
  def s_name; det.table(:index, 2)[2][2]; end
  # - Equipment Contact in Support page table
  def s_cont; det.table(:index, 2)[5][2]; end
  # - Equipment Location in Support page table
  def s_loc; det.table(:index, 2)[3][2]; end
  # - Equipment Description in Support page table
  def s_desc; det.table(:index, 2)[4][2]; end


  # - Firmware File Upload file field
  def web_file; $ie.form(:name, 'firmwareHttpForm').file_field(:id, 'Firmware File Upload'); end

  # - TFTP update firmware button
  def tftp_updt; det.button(:id, 'tftpUpdateFirmware'); end
  # - TFTP server text field
  def tftp_srvr; det.form(:name, 'firmwareTftpForm').text_field(:id, 'tftpServer'); end
  # - TFTP port text field
  def tftp_port; det.form(:name, 'firmwareTftpForm').text_field(:id, 'tftpPort'); end
  # - TFTP filename text field
  def tftp_file; det.form(:name, 'firmwareTftpForm').text_field(:id, 'tftpFilename'); end
  

  # - Network settings speed/duplex select list
  def net_speed; det.form(:name, 'configNetwork').select_list(:id, 'ethernetSpeed'); end
  # - Network settings boot mode radio buttons
  def net_bootmode(mode); det.radio(:name,'networkBootTypeGroup',"#{mode}"); end
  # - Network settings ip address text field
  def net_ipaddr; det.form(:name, 'configNetwork').text_field(:id, 'ipAddress'); end
  # - Network settings subnet mask text field
  def net_subnet; det.form(:name, 'configNetwork').text_field(:id, 'subnetMask'); end
  # - Network settings default gateway text field
  def net_gateway; det.form(:name, 'configNetwork').text_field(:id, 'defaultGateway'); end
  

  # - DNS mode radio buttons
  def dns_mode(mode); det.radio(:name, 'networkDnsModeGroup',"#{mode}"); end
  # - DNS primary DNS server text field
  def dns_addr1; det.form(:name, 'configDns').text_field(:id, 'theDns'); end
  # - DNS secondary DNS server text field
  def dns_addr2; det.form(:name, 'configDns').text_field(:id, 'theDns2'); end
  # - DNS resolve interval select list
  def dns_int; det.form(:name, 'configDns').select_list(:id, 'dnsResolveInterval'); end
  # - DNS domain name suffix text field
  def dns_suf; det.form(:name, 'configDns').text_field(:id, 'domainSuffix'); end


  # - DNS test type  select list
  def dnstype
    obj_retry("selectlist")do;det.form(:name, 'configDnsTest').select_list(:name, 'dnsQueryType'); end
  end
  # - DNS test question text field
  def dns_ques; det.form(:name, 'configDnsTest').text_field(:name, 'dnsQuestion'); end
  # - DNS test query button
  def dns_test; det.button(:name, 'dnsTest'); end


  # - Time(SNTP) time server text field
  def timesrvr; det.form(:name, 'configSntp').text_field(:id, 'timeServer'); end
  # - Time(SNTP) synchronization rate radio buttons
  def timesync(rate); det.radio(:name, 'timeSyncGroup',"#{rate}"); end
  # - Time(SNTP) timezone select list
  def timezone; det.select_list(:id, 'timezone'); end
  # - Time(SNTP) enable checkbox
  def time_enable; det.checkbox(:id, 'enableSntp'); end;
  

  # - Management protocol snmp agent checkbox
  def snmp_en; det.checkbox(:id, 'enableSNMP'); end
  # - Management protocol Velocity v.4 Server checkbox
  def v4_en; det.checkbox(:id, 'enableVelocity'); end
  # - Management protocol snmp agent checkbox on webx card
  def snmp_enable; det.checkbox(:name, 'enableSNMP'); end;

  # - Management protocol snmp agent checkbox
  def snmp_agent; det.checkbox(:id, 'enableSnmpAgent'); end
  # - Management protocol v1/v2c Protocol checkbox
  def snmp_v1v2; det.checkbox(:id, 'enableSnmpv1v2c'); end
  # - Management protocol v3 Protocol checkbox
  def snmp_v3; det.checkbox(:id, 'enableSnmpv3'); end
  
  # - SNMP authentication traps checkbox
  def snmp_auth; det.checkbox(:id, 'authenticateTrap'); end
  # - SNMP heartbeat trap interval select list
  def snmp_hb; det.form(:name, 'configSnmp').select_list(:id, 'heartbeatTrapInterval'); end
  # - SNMP rfc-1628 mib checkbox
  def upsmib; det.checkbox(:id, 'rfc1628Mib'); end
  # - SNMP rfc-1628 traps checkbox
  def upstraps; det.checkbox(:id, 'rfc1628MibTrap'); end
  # - SNMP Liebert global products (LGP) mib checkbox
  def lgpmib; det.checkbox(:id, 'lgpMib'); end
  # - SNMP Liebert global products (LGP) traps checkbox
  def lgptraps; det.checkbox(:id, 'lgpCondTrap'); end
  # - SNMP system notify traps checkbox
  def sysnotify; det.checkbox(:id, 'lgpSysNotifyTrap'); end
  

  # - SNMP access ip addess text field
  def access_addr(row); det.form(:name, 'configSnmpAccess').text_field(:name, "accessIpAddress?#{row}"); end
  # - SNMP access community string text field
  def access_com(row); det.form(:name, 'configSnmpAccess').text_field(:name, "accessCommunityString?#{row}"); end
  # - SNMP access type radio button
  def access_type(row,accs); det.radio(:name, "accessTypeGroup?#{row}", "#{accs}"); end
  # - SNMP access clear entry button
  def access_clr(row); det.button(:name, "accessClear?#{row}"); end

  
  # - SNMP trap ip addess text field
  def trap_addr(row); det.form(:name, 'configSnmpTraps').text_field(:name, "tIpA?#{row}"); end
  # - SNMP trap port text field
  def trap_port(row); det.form(:name, 'configSnmpTraps').text_field(:name, "tP?#{row}"); end
  # - SNMP trap community string text field
  def trap_com(row); det.form(:name, 'configSnmpTraps').text_field(:name, "tCS?#{row}"); end
  # - SNMP trap heartbeat enable checkbox
  def trap_hb(row); det.checkbox(:value, "?#{row}"); end
  # - SNMP trap clear entry button
  def trap_clr(row); det.button(:name, "tC?#{row}"); end
  # - SNMP test heartbeat trap button
  def test_hb; det.button(:name, 'hbTestButton'); end

 

  # -SNMP V3 settings enable checkbox
  def v3_enable(number); det.checkbox(:name, 'enableUser', "?#{number}"); end
  # -SNMP V3 settings user name text field
  def v3_user(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "informUser?#{number}"); end
  # -SNMP V3 settings authentication radio
  def v3_auth(number,authentication); det.radio(:name, "informAuthType?#{number}", "#{authentication}"); end
  # -SNMP V3 settings authentication secret tesxt field
  def v3_auth_secret(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "informAuthPass?#{number}"); end
  # -SNMP V3 settings privacy radio
  def v3_privacy(number,privacy); det.radio(:name, "informPrivType?#{number}", "#{privacy}"); end
  # -SNMP V3 settings privacy secret tesxt field
  def v3_privacy_secret(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "informPrivPass?#{number}"); end

  # -SNMP V3 settings access read check box
  def v3_acc_read(number); det.checkbox(:name, 'readAccess', "?#{number}") ; end
  # -SNMP V3 settings access write read check box
  def v3_acc_write(number); det.checkbox(:name, 'writeAccess',"?#{number}"); end
  # -SNMP V3 settings sources text field
  def v3_sources(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "informSource?#{number}"); end
  #zmg modify 2010-7-26*****************************
  # -SNMP V3 setting notify check box
  def v3_notify(number); det.checkbox(:name, 'enableNotify',"?#{number}"); end
  # -SNMP V3 settings inform trap radio
  def v3_inform_trap(number,notifytype); det.radio(:name, "notifyType?#{number}", "#{notifytype}"); end

  #******************************
  # -SNMP V3 settings destinations text field
  def v3_destinations(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "informDestination?#{number}"); end
  # -SNMP V3 settings port
  def v3_port(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "tP?#{number}"); end
  # -SNMP V3 settings Retries
  def v3_retries(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "tR?#{number}"); end
  # -SNMP V3 settings Interval
  def v3_interval(number); det.form(:name, 'configSnmpV3Simple').text_field(:name, "tI?#{number}"); end

  #zmg modify 2010-7-26*****************************
  # -SNMP V3 settings heartbeat checkbox
  def v3_heartbeat(number); det.checkbox(:name, 'enableHeartbeat',"?#{number}"); end
  #***********************************


  # -SNMP V3 settings clear button
  def v3_clear(number); det.button(:name, "informClear?#{number}"); end
  # - Messaging email enable checkbox
  def email_msg; det.checkbox(:id, 'enableSmtpEmail'); end
  # - Messaging sms enable checkbox
  def sms_msg; det.checkbox(:id, 'enableSmtpSms'); end


  # - Email from text field
  def email_from; det.form(:name, 'configSmtpEmail').text_field(:id, 'from'); end
  # - Email to text field
  def email_to; det.form(:name, 'configSmtpEmail').text_field(:id, 'to'); end
  # - Email subject type radio buttons
  def email_subjectttype(type); det.radio(:name, 'subjectTypeGroup',"#{type}"); end
  # - Email custom subject text field
  def email_custsubj; det.form(:name, 'configSmtpEmail').text_field(:id, 'subject'); end
  # - Email smtp server text field
  def email_srvr; det.form(:name, 'configSmtpEmail').text_field(:id, 'smtpServer'); end
  # - Email smtp server port
  def email_port; det.form(:name, 'configSmtpEmail').text_field(:id, 'smtpPort'); end
  # - Email test button
  def email_test;  det.button(:id, 'testEmailControl'); end


  # - SMS from text field
  def sms_from; det.form(:name, 'configSmtpSms').text_field(:id, 'from'); end
  # - SMS to text field
  def sms_to; det.form(:name, 'configSmtpSms').text_field(:id, 'to'); end
  # - SMS subject type radio buttons
  def sms_subjecttype(type); det.radio(:name, 'subjectTypeGroup',"#{type}"); end
  # - SMS custom subject text field
  def sms_custsubj; det.form(:name, 'configSmtpSms').text_field(:id, 'subject'); end
  # - SMS smtp server text field
  def sms_srvr; det.form(:name, 'configSmtpSms').text_field(:id, 'smtpServer'); end
  # - SMS smtp server port
  def sms_port; det.form(:name, 'configSmtpSms').text_field(:id, 'smtpPort'); end
  # - SMS test button
  def sms_test;  det.button(:id, 'testSmsControl'); end
  
  #define customize message functions
  # - Email include ip address checkbox
  def email_addr; det.checkbox(:id, 'enableEmailIPAddress'); end
  # - Email include event description checkbox
  def email_evtdesc; det.checkbox(:id, 'enableEmailEventDesc'); end
  # - Email include equipment name checkbox
  def email_name; det.checkbox(:id, 'enableEmailName'); end
  # - Email include equipment contact checkbox
  def email_cont; det.checkbox(:id, 'enableEmailContact'); end
  # - Email include equipment location checkbox
  def email_loc; det.checkbox(:id, 'enableEmailLocation'); end
  # - Email include equipment description checkbox
  def email_desc; det.checkbox(:id, 'enableEmailDesc'); end
  # - Email include web link & port checkbox
  def email_weblnk; det.checkbox(:id, 'enableEmailWebLinkPort'); end
  # - Email consolidation enable checkbox
  def email_consol; det.checkbox(:id, 'enableEmailConsolidation'); end
  # - Email consolidation event time limit checkbox
  def email_consoltime; det.form(:name, 'configSmtpMsg').text_field(:id, 'timeLimitEmailConsolidation'); end
  # - Email consolidation event limit checkbox
  def email_consolevt; det.form(:name, 'configSmtpMsg').text_field(:id, 'eventLimitEmailConsolidation'); end
  
  
  # - SMS include ip address checkbox
  def sms_addr; det.checkbox(:id, 'enableSMSIPAddress'); end
  # - SMS include event description checkbox
  def sms_evtdesc; det.checkbox(:id, 'enableSMSEventDesc'); end
  # - SMS include equipment name checkbox
  def sms_name; det.checkbox(:id, 'enableSMSName'); end
  # - SMS include equipment contact checkbox
  def sms_cont; det.checkbox(:id, 'enableSMSContact'); end
  # - SMS include equipment location checkbox
  def sms_loc; det.checkbox(:id, 'enableSMSLocation'); end
  # - SMS include equipment description checkbox
  def sms_desc; det.checkbox(:id, 'enableSMSDesc'); end
  # - SMS include web link & port checkbox
  def sms_weblnk; det.checkbox(:id, 'enableSmsWebLinkPort'); end
  # - SMS consolidation enable checkbox
  def sms_consol; det.checkbox(:id, 'enableSmsConsolidation'); end
  # - SMS consolidation event time limit checkbox
  def sms_consoltime; det.form(:name, 'configSmtpMsg').text_field(:id, 'timeLimitSmsConsolidation'); end
  # - SMS consolidation event limit checkbox
  def sms_consolevt; det.form(:name, 'configSmtpMsg').text_field(:id, 'eventLimitSmsConsolidation'); end


 


  # - Telnet enable checkbox
  def telnet1; det.checkbox(:id, 'enableTelnet'); end


  # - Admin username text field
  def admin_name; det.form(:name, 'configUser').text_field(:id, 'usernameAdmin'); end
  # - Admin password text field
  def admin_pswd; det.form(:name, 'configUser').text_field(:id, 'passwordAdmin'); end
  # - Admin reenter password text field
  def admin_pswd2; det.form(:name, 'configUser').text_field(:id, 'password2Admin'); end
  # - General user username text field
  def user_name; det.form(:name, 'configUser').text_field(:id, 'usernameUser'); end
  # - General password text field
  def user_pswd; det.form(:name, 'configUser').text_field(:id, 'passwordUser'); end
  # - General reenter password text field
  def user_pswd2; det.form(:name, 'configUser').text_field(:id, 'password2User'); end


  #Constants for websrvr combo box
  DISABLED = '00000000'
  HTTP = '00000001'
  HTTPS = '00000002'
  # - Web server mode delect list
  def websrvr; det.form(:name, 'configWeb').select_list(:id, 'webMode'); end
  # - Web server http port text field
  def httpport; det.form(:name, 'configWeb').text_field(:id, 'webPort'); end
  # - Web server https port text field
  def httpsport; det.form(:name, 'configWeb').text_field(:id, 'webSecurePort'); end
  # - Web server enable password protect site checkbox
  def pswdprtct; det.checkbox(:id, 'enableWebPassword'); end
  # - Web server enable configuration and control checkbox
  def cfgctrl; det.checkbox(:id, 'enableWebCfgCtrl'); end
  # - Web server refresh interval text field
  def refresh; det.form(:name, 'configWeb').text_field(:id, 'webRefresh'); end
 

  # - Information table iterator
  def param_descr(idx,row_start,j); det.table(:index, "#{idx}")[row_start][j]; end

  # - Support table 
  #def supprt; det.table(:index, 2).to_a .compact; end
  def supprt
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /tabArea/ then $ie.frame(:index, 3).frame(:index, 3).table(:index, 2).to_a .compact
    else det.table(:index, 2).to_a .compact
    end
  end
  
  # - Information table iterator for web firmware update
  def param_firmwrweb(idx,row_start,j);$ie.table(:index, "#{idx}")[row_start][j]; end

  # - Helper methods
  
  # - Returns an array with all of the text based hyperlinks
  #TODO - extend to accept an argument to populate different link types
  def populate_links_array
    for i in 1..@num_frames
      @links_array[i] = Array.new
      $ie.frame(:index, i).links.each { |l| @links_array[i] << l }
    end
    @links_array.compact!
  end

  # - Searches through each frame for images named <code>image_name</code> and clicks
  def click_all(image_name)
    for i in 1..@num_frames
      $ie.frame(:index, i).images.each do |image|
        if image.src =~ /#{image_name}/
          image.click
          sleep(1.5) #TODO Figure out a way to remove this sleep
        end
      end
    end
  end

  #This method is used to count the number of images
  def count_images(image_name)
    image_count = 0
    for i in 1..@num_frames
      $ie.frame(:index, i).images.each do |image|
        if image.src =~ /#{image_name}/
          image_count +=1
        end
      end
    end
    puts "Found #{image_count} occurences of #{image_name}"
    return image_count
  end

  # - Returns the number of frames by capturing the output of show_frames,
  # - counting the number of lines, and subtracting 1
  def count_frames
    frame_text = self.redirect {$ie.show_frames}
    frame_text.each_line {|line| @num_frames += 1}
    @num_frames -= 1
  end

  #This method is used to redirect stdout to a string
  def redirect
    orig_defout = $defout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = orig_defout
  end

end