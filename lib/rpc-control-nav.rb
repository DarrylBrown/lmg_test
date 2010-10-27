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


module Controlnav


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

end