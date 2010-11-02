=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Module_Name*
  Navigate

*Description*
  Object repository for:(Device Explorer and Receptacle Sequence
    - navigation tabs
    - navigation links
    - buttons
    - radio buttons
    - tables
    - text fields

*Variables*

=end


module DevExpRcpSeq


  #  - Tab area frameset abstraction
  def tab
    frame_text = self.redirect {$ie.show_frames}
    if frame_text =~ /tabArea/ then $ie.frame(:name, 'tabArea')
    else $ie
    end
  end
  
  
  # - Navigation link frameset abstraction
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

  
  # - RPC-Device Explorer navigation link   
  # - monitor tab link
  def monitor; tab.image(:name, 'imgMonitor'); end
  
  # - control tab link
  def control; tab.image(:name, 'imgControl'); end

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


end