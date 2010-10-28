=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Module_Name*
  ControlNavigate

*Description*
  Object repository for:(Monitor Tab)
    - navigation tabs
    - navigation links
    - buttons
    - radio buttons
    - tables
    - text fields

*Variables*

=end


module Monitornav
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
  
end