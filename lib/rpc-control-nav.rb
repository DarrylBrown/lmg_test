#**************************************PDU-Explorer************************************
#Control tab
module Controlnav
#  - Tab area frameset abstration
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

#PDU-Explorer Link
#$ie.frame(:index, 3).frame(:index, 2).link(:text, 'PDU Explorer').click
def pdu_exp; nav.link(:text, 'PDU Explorer'); end

#PDU-1 Tab
=begin
$ie.frame(:index, 3).frame(:index, 3).image(:index, 2).click
#PDU-2 Tab
$ie.frame(:index, 3).frame(:index, 3).image(:index, 10).click
#PDU-3 Tab
$ie.frame(:index, 3).frame(:index, 3).image(:index, 18).click
#PDU-4 Tab
$ie.frame(:index, 3).frame(:index, 3).image(:index, 26).click
=end
def pdu(id); det.image(:index, "#{id}"); end

#PDU1-Scroll to Branch level
=begin
$ie.frame(:index, 3).frame(:index, 3).image(:index, 3).click
#PDU2-Scroll to Branch level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 11).click
#PDU3-Scroll to Branch level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 19).click
#PDU4-Scroll to Branch level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 27).click
=end
def scroll(id); det.image(:index, "#{id}"); end

#PDU1 Settings Tab
def cntrl_settg; det.image(:id, 'imgCtrlSettings'); end

def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetailArea'); end
#PDU1 Settings Parameters

#PDU User Assigned Label
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'label').set('MPH Rack PDU1')
def pusr_lbl; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'label'); end

#PDU Asset Tag01
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag1').set('')
def ptag1; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag1'); end

#PDU Asset Tag02
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag2').set('')
def ptag2; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag2'); end

#Branch User Assigned Label
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'label').set('MPH Rack PDU1')
def busr_lbl; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'label'); end

#Branch Asset Tag01
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag1').set('')
def btag1; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'assetTag1'); end

#Branch Asset Tag02
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag2').set('')
def btag2; catdet.form(:name, 'rpcControlRemSettingForm').text_field(:name, 'assetTag2'); end

#Receptacle User Assigned Label
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'label').set('MPH Rack PDU1')
def rusr_lbl; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'label'); end

#Receptacle Asset Tag01
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag1').set('')
def rtag1; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'assetTag1'); end

#Receptacle Asset Tag02
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'assetTag2').set('')
def rtag2; catdet.form(:name, 'rpcControlReceptacleSettingForm').text_field(:name, 'assetTag2'); end

#Neutral Over Current Alarm Threshold
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverAlarm').set('80')
def neutovr_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverAlarm'); end

#Neutral Over Current Warning Threshold
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverWarn').set('75')
def neutovr_wrn; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecNeutralThrshldOverWarn'); end

#Over Current Alarm Threshold
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiAlmLN').set('80')
def ovr_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiAlmLN'); end

#Over Current Warning Threshold
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiWrnLN').set('75')
def ovr_wrn; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdHiWrnLN'); end

#Low  Current Alarm  Threshold
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdLoAlmLN').set('0')
def low_alrm; catdet.form(:name, 'rpcControlApsSettingForm').text_field(:name, 'ecThresholdLoAlmLN'); end
 
#PDU1 Commands Tab    
def cntrl_cmnd; det.image(:id, 'imgCtrlCommands'); end

#PDU Accumulated Energy Reset button
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).button(:name, 'energyControl').click
def accum_en; catdet.button(:name, 'energyControl'); end

#Generic Test Event
#$ie.frame(:index, 3).frame(:index, 3).frame(:index, 1).button(:name, 'testEvent').click
def gentest; catdet.button(:name, 'testEvent'); end

#Receptacle Power On Delay
#$IE0.frame(:index, 3).frame(:index, 3).frame(:index, 1).form(:name, 'rpcControlReceptacleSettingForm').text_field(:id, 'powerUpDelay').set('0')
def rcp_delay;catdet.text_field(:id, 'powerUpDelay');end

#Receptacle Control Lock State
#$IE0.frame(:index, 3).frame(:index, 3).frame(:index, 1).radio(:name, 'lockStateTypeGroup1', '0').set
def rcp_lockstate;catdet.radio(:name, 'lockStateTypeGroup1', "#{mode}");end

#Receptacle commands receptacle power state
#$IE0.frame(:index, 3).frame(:index, 3).frame(:index, 1).radio(:name, 'receptacleStateGroup', '1').set
def rcp_powerstate;radio(:name, 'receptacleStateGroup', "#{mode}");end

#Receptacle LED
def rcp_led; catdet.button(:name, 'rcpIdentControl'); end

#Control Edit,Save,Reset
def p_edit; catdet.button(:name, 'Edit'); end
def b_edit; catdet.button(:id, 'editButton'); end
def r_edit; catdet.button(:id, 'edit').click; end
def c_save; catdet.button(:name, 'Submit'); end
def c_reset; catdet.button(:value, 'Reset'); end

end