=begin rdoc
******Revisions******
  | Change                                               | Name        | Date  |

*Module_Name*
  ControlNavigate

*Description*
  Object repository for:(Sensors)
    - navigation tabs
    - navigation links
    - buttons
    - radio buttons
    - tables
    - text fields

*ariables*

=end


module Sensors


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
  
  #Category Details area frameset abstraction
  def catdet; $ie.frame(:name, 'infoArea').frame(:name, 'detailArea').frame(:name, 'categDetail'); end
  
  # - monitor tab link
  def monitor; tab.image(:name, 'imgMonitor'); end

  # - control tab link
  def control; tab.image(:name, 'imgControl'); end


  #Sensors link
  def sensr; nav.link(:text, 'Sensors'); end

  #Status tab
  def s_status; det.image(:id, 'imgStatus'); end

  #Events tab
  def s_events; det.image(:id, 'imgEvents'); end

  #Setting tab
  def s_settgs; det.image(:id, 'imgSettings'); end

  #Ratings tab
  def s_ratings; det.image(:id, 'imgInfo'); end

  #Sensors ID Sort Link
  def s_idsort; det.link(:text, 'ID'); end

  #Sensors Type Sort Link
  def s_typesort; det.link(:text, 'Type'); end

  #Sensors Label Sort Link
  def s_label; det.link(:text, 'Label'); end

  #Sensor status table entry
  def sen_status(row,column); det.table(:index, 10)[row][column]; end

  #Sensor events table entry
  def sen_events(row,column); det.table(:index, 11)[row][column]; end

  #Sensor settings table entry
  def sen_settg(row,column); det.table(:index, 12)[row][column]; end

  #Sensor ratings table entry
  def sen_ratg(row,column); det.table(:index, 13)[row][column]; end

  #Humidity labels,asset tags,thresholds
  #Humidity User Assigned Label text field
  def h_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdLabel'); end
  
  #Humidity Asset Tag 01 text field
  def h_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag1'); end
  
  #Humidity Asset Tag 02 text field  
  def h_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'hmdAssetTag2'); end
  
  #Over Relative Humidity Alarm Threshold text field 
  def h_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiAlm'); end
  
  #Over Relative Humidity Warning Threshold text field
  def h_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'humThresholdHiWrn'); end
  
  #Under Relative Humidity Warning Threshold text field
  def h_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoAlm'); end
  
  #Under Relative Humidity Alarm Threshold text field
  def h_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'humThresholdLoWrn'); end


  #Temperature labels,asset tags,thresholds
  #Temperature User Assigned Label text field
  def t_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpLabel'); end
  
  #Temperature Asset Tag 01 text field
  def t_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag1'); end
  
  #Temperature Asset Tag02 text field
  def t_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tmpAssetTag2'); end
  
  #Over Temperature Alarm Threshold text field
  def t_ovralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiAlm'); end
  
  #Over Temperature Warning Threshold text field
  def t_ovrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'tempThresholdHiWrn'); end
  
  #Under Temperature Warning Threshold text field
  def t_undralrm; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoAlm'); end
  
  #Under Temperature Alarm Threshold text field
  def t_undrwrng; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,'tempThresholdLoWrn'); end


  #Door Closure labels,asset tags,state alarm config
  #Door Closure Sensor User Assigned Label text field			
  def d_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drLabel'); end
  
  #Door Closure Sensor Asset Tag 01 text field
  def d_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'drAssetTag1'); end
  
  #Door Closure Sensor Asset Tag 02 text field
  def d_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'drAssetTag2'); end
  
  #Door Closure State Alarm Config radio button
  def d_alrmcnfg(state); catdet.radio(:name, 'drStateAlrmCfg',"#{state}"); end

  #Contact Closure labels,asset tags,state alarm config
  #Contact Closure Sensor User Assigned Label text field
  def c_usrlbl; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctLabel'); end
  
  #Contact Closure Sensor Asset Tag 01 text field
  def c_asstag1; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id,  'cntctAssetTag1'); end
  
  #Contact Closure Sensor Asset Tag 02 text field
  def c_asstag2; catdet.form(:name, 'rpcControlSensorSettingForm').text_field(:id, 'cntctAssetTag2'); end
  
  #Contact Closure Alarm State Config Radio button
  def c_alrmcnfg(state); catdet.radio(:name, 'cntctStateAlrmCfg',"#{state}"); end


  #Sensor ID link
  #def sensrid(id); det.link(:text, "#{id}"); end
  def sensrid(id); $ie.frame(:index, 3).frame(:index, 3).link(:text, "#{id}"); end

  #Sensors Edit button
  def s_edit; catdet.button(:id, 'editButton'); end


end