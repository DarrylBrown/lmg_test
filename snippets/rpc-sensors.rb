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
  
def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetailArea'); end
  
# - monitor tab link
def monitor; tab.image(:name, 'imgMonitor'); end

# - control tab link
def control; tab.image(:name, 'imgControl'); end


#Click on Sensors link
def sensr; nav.link(:text, 'Sensors'); end

#Click on Status tab
def sstatus; det.image(:id, 'imgStatus'); end

#Click on events tab
def sevents; det.image(:id, 'imgEvents'); end

#Click on Setting tab
def ssettgs; det.image(:id, 'imgSettings'); end

#Click on Ratings tab
def sratings; det.image(:id, 'imgInfo'); end

#click on Sensors ID Sort
def sidsort; det.link(:text, 'ID'); end

#click on Sensors Type Sort
def stypesort; det.link(:text, 'Type'); end

#click on Sensors Label Sort
def slabel; det.link(:text, 'Label'); end

#Sensor status
def senstatus(row,column); det.table(:index, 10)[row][column]; end

#Sensor events
def senevents(row,column); det.table(:index, 11)[row][column]; end

#Sensor settings
def sensettg(row,column); det.table(:index, 12)[row][column]; end

#Sensor ratings
def senratg(row,column); det.table(:index, 13)[row][column]; end

#Humidity labels,asset tags,thresholds
def husrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdLabel'); end
def hasstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag1'); end
def hasstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag2'); end
def hovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiAlm'); end
def hovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiWrn'); end
def hundralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoAlm'); end
def hundrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoWrn'); end


#Temperature labels,asset tags,thresholds
def tusrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpLabel'); end
def tasstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag1'); end
def tasstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag1'); end
def tovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiAlm'); end
def tovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiWrn'); end
def tundralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoAlm'); end
def tundrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoWrn'); end


#Door Closure labels,asset tags,state alarm config
def dusrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drLabel'); end
def dasstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'drAssetTag1'); end
def dasstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drAssetTag2'); end
def dalrmcnfg(state); catdet.radio(:name, 'drStateAlrmCfg',"#{state}"); end

#Contact Closure labels,asset tags,state alarm config
def cusrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctLabel'); end
def casstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'cntctAssetTag1'); end
def casstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctAssetTag2'); end
def calrmcnfg(state); catdet.radio(:name, 'cntctStateAlrmCfg',"#{state}"); end


#click on Sensor ID link for ex :-4 -1-1
def snsrid(id); det.link(:text, "#{id}"); end

end