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

  # - monitor tab link
  def monitor; tab.image(:name, 'imgMonitor'); end
  
  # - control tab link
  def control; tab.image(:name, 'imgControl'); end
  
  #Device Explorer Link  
  #$ie.frame(:index, 3).frame(:index, 2).link(:text, 'Device Explorer').click
  def dev_exp; nav.link(:text, 'Device Explorer'); end

  #Receptacle Sequence Link
  #$ie.frame(:index, 3).frame(:index, 2).link(:text, 'Receptacle Sequence').click
  def rcp_sequence;nav.link(:text, 'Receptacle Sequence');end

  #Receptacle Sequence-Header --Sort by delay link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'Delay').click
  def sort_delay ;det.link(:text, 'Receptacle Sequence');end

  #Delay for All Receptacle-Table Entry 
  #$ie.frame(:index, 3).frame(:index, 3).table(:id, 'rcpTable')[2][1].click
  def rcp_table(row,column); det.table(:id, 'rcpTable')[row][column];end

  #Label text field
  #$ie.frame(:index, 3).frame(:index, 3).form(:index, 1).text_field(:id, 'searchBox').set('')
  def dev_label; det.form(:id, 'rpcControlReceptacleListForm').text_field(:id, 'searchBox'); end

  #Receptacle Name link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'Receptacle 1').click
  def rcpname(id); det.link(:text, "#{id}"); end

  #Receptacle Id link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, '1-1-1').click
  def rcpid(id); det.link(:text,"#{id}"); end

  #Select All checkbox
  #$ie.frame(:index, 3).frame(:index, 3).checkbox(:id, 'selectAll').set(set_or_clear=true)
  def select_all; det.checkbox(:id, 'selectAll'); end

  #Select individual checkboxes
  #$ie.frame(:index, 3).frame(:index, 3).checkbox(:id, '1_0').set(set_or_clear=true)
  def select_one(idx); det.checkbox(:id, "#{idx}"); end

  #Control Actions
  #Receptacle Power State dropdownlist
  #$ie.frame(:index, 3).frame(:index, 3).form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpStateAction').select_value('0')
  def rcpstate; det.form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpStateAction'); end

  #Receptacle Lock State dropdownlist
  #$ie.frame(:index, 3).frame(:index, 3).form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpLockAction').select_value('0')
  def rcplckstate; det.form(:id, 'rpcControlReceptacleListForm').select_list(:id, 'rcpLockAction'); end

  #Receptacle Power State Save button
  #$ie.frame(:index, 3).frame(:index, 3).button(:id, 'Save').click
  def rcpstsave; det.button(:id, 'Save'); end

  #Receptacle Lock State Save button
  #$ie.frame(:index, 3).frame(:index, 3).button(:id, 'lockStateButton').click
  def rcplcksave; det.button(:id, 'lockStateButton'); end

  #Device Explorer --Headers
  #Receptacle Name Sort Link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'Receptacle User Assigned Label').click
  def label_sort; det.link(:text, 'Receptacle User Assigned Label'); end

  #Receptacle Id Sort Link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'Id').click
  def id_sort; det.link(:text, 'Id'); end

  #Receptacle On/Off Sort Link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'O').click
  def onoff_sort; det.link(:text, 'O'); end

  #Receptacle Control Sort link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'C').click
  def control_sort; det.link(:text, 'C'); end

  #Receptacle Status Sort Link
  #$ie.frame(:index, 3).frame(:index, 3).link(:text, 'S').click
  def status_sort; det.link(:text, 'S'); end

end