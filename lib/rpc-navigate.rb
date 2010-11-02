=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Module_Name*
  ControlNavigate

*Description*
  Object repository for:(Control Tab)
    - navigation tabs
    - navigation links
    - buttons
    - radio buttons
    - tables
    - text fields

*Variables*

=end

module RpcNav

 #  - Tab area frameset abstraction
 def tab
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /tabArea/ then $ie.frame(:name, 'tabArea')
    else $ie
    end
 end
  
  
 # - Navigation link frameset abstration
  def nav
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /infoArea/ then $ie.frame(:name, 'infoArea').frame(:name, 'navTreeArea')
    else $ie.frame(:id, 'navigationFrame')
    end
  end

  
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

  # - RPC-Control information navigation link.
  # - control tab link
  def control; tab.image(:name, 'imgControl'); end

  # - PDU-Explorer Link
  def pdu_exp; nav.link(:text, 'PDU Explorer'); end

  # - PDU-ID Link
  def pdu(id); det.image(:index, "#{id}"); end

  # - PDU-Scroll to Branch level Link
  def scroll(id); det.image(:index, "#{id}"); end
  
  # - PDU Settings Tab Link
  def cntrl_settg; det.image(:id, 'imgCtrlSettings'); end

  # - Category Details area frameset abstraction
  def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetailArea'); end

  # - PDU Settings Parameters
  # - PDU User Assigned Label text field
  def pusr_lbl; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'label'); end

  # - PDU Asset Tag01 text field
  def ptag1; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag1'); end

  # - PDU Asset Tag02 text field
  def ptag2; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag2'); end
  
  # - Neutral Over Current Alarm Threshold text field
  def neutovr_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverAlarm'); end

  # - Neutral Over Current Warning Threshold text field
  def neutovr_wrn; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverWarn'); end

  # - Over Current Alarm Threshold text field
  def ovr_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiAlmLN'); end

  # - Over Current Warning Threshold text field
  def ovr_wrn; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiWrnLN'); end

  # - Low  Current Alarm  Threshold text field
  def low_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdLoAlmLN'); end

  # - Branch Settings Parameters 
  # - Branch User Assigned Label text field
  def busr_lbl; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'label'); end

  # - Branch Asset Tag01 text field
  def btag1; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'assetTag1'); end

  # - Branch Asset Tag02 text field
  def btag2; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'assetTag2'); end

  # - Receptacle Settings Parameters
  # - Receptacle User Assigned Label text field
  def rusr_lbl; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'label'); end

  # - Receptacle Asset Tag01 text field
  def rtag1; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'assetTag1'); end

  # - Receptacle Asset Tag02 text field
  def rtag2; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'assetTag2'); end

  # - Receptacle Power On Delay text field
  def rcp_delay;catdet.text_field(:id, 'powerUpDelay');end
  
  # - Receptacle Control Lock State radio button
  def rcp_lockstate;catdet.radio(:name, 'lockStateTypeGroup1', "#{mode}");end
 
  # - PDU Commands Tab Link   
  def cntrl_cmnd; det.image(:id, 'imgCtrlCommands'); end

  # - PDU Commands
  # - PDU Accumulated Energy Reset button
  def accum_en; catdet.button(:name, 'energyControl'); end

  # - Generic Test Event button
  def gentest; catdet.button(:name, 'testEvent'); end

  # - Receptacle Commands
  # - Receptacle power state radio button
  def rcp_powerstate;radio(:name, 'receptacleStateGroup', "#{mode}");end

  # - Receptacle LED button
  def rcp_led; catdet.button(:name, 'rcpIdentControl'); end

  # - Control Edit,Save,Reset
  # - PDU 
  def p_edit; catdet.button(:name, 'Edit'); end
   
  # - Branch 
  def b_edit; catdet.button(:id, 'editButton'); end
  
  # - Receptacle 
  def r_edit; catdet.button(:id, 'edit'); end
  
  # - Save button
  def c_save; catdet.button(:name, 'Submit'); end
  
  # - Reset button
  def c_reset; catdet.button(:value, 'Reset'); end

  
  
  # - RPC-Monitor information navigation link
  # - monitor tab link
  def monitor; tab.image(:name, 'imgMonitor'); end  


  # - PDU-Explorer Link
  def pdu_exp; nav.link(:text, 'PDU Explorer'); end
  # - Status Tab
  def m_status; det.image(:id, 'imgStatus'); end
  # - Events Tab
  def m_events; det.image(:id, 'imgEvents'); end
  # - Settings Tab
  def m_settings; det.image(:id, 'imgSettings'); end
  # - Ratings Tab
  def m_ratings; det.image(:id, 'imgInfo'); end
  # - PDU-Status >> Parameters Table Entries
  def status(row,param); det.table(:index, 9)[row][param]; end
  # - PDU-Events >> Parameters Table Entries
  def events(row,column); det.table(:index, 10)[row][column]; end
  # - Receptacle-Settings >> Parameters Table Entries
  def settings(row,column); det.table(:index, 11)[row][column]; end
  # - Receptacle-Ratings >> Parameters Table Entries
  def ratings(row,column); det.table(:index, 12)[row][column]; end

  # - PDU Tabs
  def pdu(id); det.image(:index, "#{id}"); end
  # - PDU - Branch Scroll
  def scroll(id); det.image(:index, "#{id}"); end
  # - PDU-Branch-Receptacle Level

  
  
  # - RPC-Device Explorer navigation link  
  # - Device Explorer Link  
  def dev_exp; nav.link(:text, 'Device Explorer'); end
  
  # - Select All checkbox
  def select_all; det.checkbox(:id, 'selectAll'); end

  # - Select individual checkboxes
  def select_one(idx); det.checkbox(:id, "#{idx}"); end

  # - Receptacle Power State dropdownlist
  def rcpstate; det.form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpStateAction'); end

  # - Receptacle Lock State dropdownlist
  def rcplckstate; det.form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpLockAction'); end

  # - Receptacle Power State Save button
  def rcpstsave; det.button(:id, 'Save'); end

  # - Receptacle Lock State Save button
  def rcplcksave; det.button(:id, 'lockStateButton'); end
  
  # - Label text field
  def dev_label; det.form(:id, 'rpcControlReceptacleListForm').text_field(:id, 'searchBox'); end

  # - Receptacle Sequence Link
  def rcp_sequence;nav.link(:text, 'Receptacle Sequence');end

  # - Receptacle Sequence-Header --Sort by delay link
  def sort_delay ;det.link(:text, 'Receptacle Sequence');end

  # - Delay for All Receptacle-Table Entry 
  def rcp_table(row,column); det.table(:id, 'rcpTable')[row][column];end

  # - Common fields in Device Explorer and Receptacle Sequence
  # - Receptacle Name Link
  def rcpname(id); det.link(:text, "#{id}"); end
  
  # - Receptacle Id Link
  def rcpid(id); det.link(:text,"#{id}"); end
  
  # - Label Sort Link
  def label_sort; det.link(:text, 'Receptacle User Assigned Label'); end

  # - ID Sort Link
  def id_sort; det.link(:text, 'Id'); end
  
  # - OnOff Sort link
  def onoff_sort; det.link(:text, 'O'); end
  
  # - Control Sort Link
  def control_sort; det.link(:text, 'C'); end
  
  # - Status Sort Link
  def status_sort; det.link(:text, 'S'); end

  
   # - Sensors navigation link
   # - Category Details area frameset abstraction
  def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetail'); end
   
  # - Sensors link
  def sensr; nav.link(:text, 'Sensors'); end
  # - Status tab
  def s_status; det.image(:id, 'imgStatus'); end
  # - Events tab
  def s_events; det.image(:id, 'imgEvents'); end
  # - Setting tab
  def s_settgs; det.image(:id, 'imgSettings'); end
  # - Ratings tab
  def s_ratings; det.image(:id, 'imgInfo'); end
  # - Sensors ID Sort Link
  def s_idsort; det.link(:text, 'ID'); end
  # - Sensors Type Sort Link
  def s_typesort; det.link(:text, 'Type'); end
  # - Sensors Label Sort Link
  def s_label; det.link(:text, 'Label'); end
  # - Sensor status table entry
  def sen_status(row,column); det.table(:index, 10)[row][column]; end

  # - Sensor events table entry
  def sen_events(row,column); det.table(:index, 11)[row][column]; end
  # - Sensor settings table entry
  def sen_settg(row,column); det.table(:index, 12)[row][column]; end
  # - Sensor ratings table entry
  def sen_ratg(row,column); det.table(:index, 13)[row][column]; end

  # - Humidity labels,asset tags,thresholds
  # - Humidity User Assigned Label text field
  def h_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdLabel'); end
  # - Humidity Asset Tag 01 text field
  def h_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag1'); end
  # - Humidity Asset Tag 02 text field  
  def h_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag2'); end
  # - Over Relative Humidity Alarm Threshold text field 
  def h_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiAlm'); end
  # - Over Relative Humidity Warning Threshold text field
  def h_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiWrn'); end
  # - Under Relative Humidity Warning Threshold text field
  def h_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoAlm'); end
  # - Under Relative Humidity Alarm Threshold text field
  def h_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoWrn'); end

  
  # - Temperature labels,asset tags,thresholds
  # - Temperature User Assigned Label text field
  def t_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpLabel'); end
  # - Temperature Asset Tag01 text field
  def t_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag1'); end
  # - Temperature Asset Tag02 text field
  def t_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag2'); end
  # - Over Temperature Alarm Threshold text field
  def t_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiAlm'); end
  # - Over Temperature Warning Threshold text field
  def t_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiWrn'); end
  # - Under Temperature Warning Threshold text field
  def t_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoAlm'); end
  # - Under Temperature Alarm Threshold text field
  def t_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoWrn'); end


  # - Door Closure labels,asset tags,state alarm config
  # - Door Closure Sensor User Assigned Label text field			
  def d_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drLabel'); end
  # - Door Closure Sensor Asset Tag 01 text field
  def d_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'drAssetTag1'); end
  # - Door Closure Sensor Asset Tag 02 text field
  def d_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drAssetTag2'); end
  # - Door Closure State Alarm Config radio button
  def d_alrmcnfg(state); catdet.radio(:name, 'drStateAlrmCfg',"#{state}"); end
  
  
  # - Contact Closure labels,asset tags,state alarm config
  # - Contact Closure Sensor User Assigned Label text field
  def c_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctLabel'); end
  # - Contact Closure Sensor Asset Tag 01 text field
  def c_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'cntctAssetTag1'); end
  # - Contact Closure Sensor Asset Tag 02 text field
  def c_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctAssetTag2'); end
  # - Contact Closure Alarm State Config Radio button
  def c_alrmcnfg(state); catdet.radio(:name, 'cntctStateAlrmCfg',"#{state}"); end

  # - Sensor ID link
  def sensrid(id); $ie.frame(:index, 3).frame(:index, 3).link(:text, "#{id}"); end

  # - Sensors Edit button
  def s_edit; catdet.button(:id, 'editButton'); end


end
