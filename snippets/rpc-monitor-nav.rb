#**************************************PDU-Explorer************************************#
#Monitor Tab
module Monitornav
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
  
# - monitor tab link
def monitor; tab.image(:name, 'imgMonitor'); end  

#PDU-Explorer Link
#$ie.frame(:index, 3).frame(:index, 2).link(:text, 'PDU Explorer').click
def pdu_exp; nav.link(:text, 'PDU Explorer'); end

#Status
#$ie.frame(:index, 3).frame(:index, 3).image(:id, 'imgStatus').click
def m_status; det.image(:id, 'imgStatus'); end

#Events
#$ie.frame(:index, 3).frame(:index, 3).image(:id, 'imgEvents').click
def m_events; det.image(:id, 'imgEvents'); end

#Settings
#$ie.frame(:index, 3).frame(:index, 3).image(:id, 'imgSettings').click
def m_settings; det.image(:id, 'imgSettings'); end

#Ratings
#$ie.frame(:index, 3).frame(:index, 3).image(:id, 'imgInfo').click
def m_ratings; det.image(:id, 'imgInfo'); end

#PDU-Status---->Parameters
=begin
#Supported Status 
#$ie.frame(:index, 3).frame(:index, 3).table(:index, 9)[2][1].click
#Value
#$ie.frame(:index, 3).frame(:index, 3).table(:index, 9)[2][2].click
#Units
#$ie.frame(:index, 3).frame(:index, 3).table(:index, 9)[2][3].click
=end
def status(row,param); det.table(:index, 9)[row][param]; end

#PDU-Events---->Parameters
=begin
#Supported Events
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[2][2].click
#Status
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[2][3].click
=end
def events(row,column); det.table(:index, 10)[row][column]; end

#PDU-Settings---->Parameters
#Branch-Settings---->Parameters
#Receptacle-Settings---->Parameters
=begin
#Supported Settings
$ie.frame(:index, 3).frame(:index, 3).table(:index, 11)[2][1].click
#Value
$ie.frame(:index, 3).frame(:index, 3).table(:index, 11)[2][2].click
#Units
$ie.frame(:index, 3).frame(:index, 3).table(:index, 11)[2][3].click
=end
def settings(row,column); det.table(:index, 11)[row][column]; end

#PDU-Ratings---->Parameters
#Branch-Ratings---->Parameters
#Receptacle-Ratings---->Parameters
=begin
#Ratings and Information
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][1].click
#Value
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][2].click
#Units
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][3].click
=end

def ratings(row,column); det.table(:index, 12)[row][column]; end

#Receptacle-Settings---->Parameters
=begin
#Supported Settings
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[1][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[2][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[3][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[4][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[5][1].click

#Value
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[1][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[2][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[3][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[4][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[5][2].click

#Units
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[1][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[2][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[3][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[4][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 10)[5][3].click     
=end   

#Receptacle-Ratings---->Parameters
=begin
#Ratings and Information
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[1][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[3][1].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[4][1].click

#Value
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[1][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[3][2].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[4][2].click   

#Units
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[1][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[2][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[3][3].click
$ie.frame(:index, 3).frame(:index, 3).table(:index, 12)[4][3].click
=end

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

#PDU1-Branch1-Receptacle Level
=begin
$ie.frame(:index, 3).frame(:index, 3).image(:index, 3).click
#PDU2-Branch1-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 3).click
#PDU3-Branch1-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 3).click
#PDU3-Branch2-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 6).click
#PDU3-Branch3-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 9).click
#PDU4-Branch1-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 3).click
#PDU4-Branch1-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 6).click
#PDU4-Branch1-Receptacle Level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 9).click

#Scroll back from Receptacle to Branch level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 29).click
#Scroll back from Branch to PDU level
$ie.frame(:index, 3).frame(:index, 3).image(:index, 5).click
=end


end