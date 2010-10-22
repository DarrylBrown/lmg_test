#**************************************Sensors************************************

module Sensors
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
  
def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetail'); end
  
# - monitor tab link
def monitor; tab.image(:name, 'imgMonitor'); end

# - control tab link
def control; tab.image(:name, 'imgControl'); end


#Click on Sensors link
def sensr; nav.link(:text, 'Sensors'); end

#Click on Status tab
def s_status; det.image(:id, 'imgStatus'); end

#Click on events tab
def s_events; det.image(:id, 'imgEvents'); end

#Click on Setting tab
def s_settgs; det.image(:id, 'imgSettings'); end

#Click on Ratings tab
def s_ratings; det.image(:id, 'imgInfo'); end

#click on Sensors ID Sort
def s_idsort; det.link(:text, 'ID'); end

#click on Sensors Type Sort
def s_typesort; det.link(:text, 'Type'); end

#click on Sensors Label Sort
def s_label; det.link(:text, 'Label'); end

#Sensor status
def sen_status(row,column); det.table(:index, 10)[row][column]; end

#Sensor events
def sen_events(row,column); det.table(:index, 11)[row][column]; end

#Sensor settings
def sen_settg(row,column); det.table(:index, 12)[row][column]; end

#Sensor ratings
def sen_ratg(row,column); det.table(:index, 13)[row][column]; end

#Humidity labels,asset tags,thresholds
def h_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdLabel'); end
def h_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag1'); end
def h_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag2'); end
def h_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiAlm'); end
def h_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiWrn'); end
def h_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoAlm'); end
def h_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoWrn'); end


#Temperature labels,asset tags,thresholds
def t_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpLabel'); end
def t_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag1'); end
def t_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag2'); end
def t_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiAlm'); end
def t_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiWrn'); end
def t_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoAlm'); end
def t_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoWrn'); end


#Door Closure labels,asset tags,state alarm config
def d_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drLabel'); end
def d_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'drAssetTag1'); end
def d_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drAssetTag2'); end
def d_alrmcnfg(state); catdet.radio(:name, 'drStateAlrmCfg',"#{state}"); end

#Contact Closure labels,asset tags,state alarm config
def c_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctLabel'); end
def c_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'cntctAssetTag1'); end
def c_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctAssetTag2'); end
def c_alrmcnfg(state); catdet.radio(:name, 'cntctStateAlrmCfg',"#{state}"); end


#click on Sensor ID link for ex :-4 -1-1
#def sensrid(id); det.link(:text, "#{id}"); end
def sensrid(id); $ie.frame(:index, 3).frame(:index, 3).link(:text, "#{id}"); end

#Sensors Edit button
def s_edit; catdet.button(:id, 'editButton'); end


end