=begin rdoc

*Revisions*
  | Change                                               | Name        | Date  |

*Test_Script_Name*
  cfg_equi_info_layout_webx

*Test_Case_Number*
  700.010.10.110

*Description*
  Validate the Web Configuration Categories Table

*Variable_Definitions*

=end

#Add library file to the path
$:.unshift File.dirname(__FILE__).chomp('driver')<<'lib' # add library to path

s = Time.now

require 'generic'

TABLE_NUMBER_COLUMN = 'A'
EXPECTED_COLUMN = 'B'
ACTUAL_COLUMN = 'C'

begin
  puts" \n Executing: #{(__FILE__)}\n\n" # print current filename
  g = Generic.new
  roe = ARGV[1].to_i
  #Open up a new excel instance and save it with the timestamp.
  #Open the IE browser
  #Collect the support page information and save it in the time stamped spreadsheet.
  excel = g.setup(__FILE__)
  wb,ws = excel[0][1,2]
  rows = excel[1][1]

  $ie.speed = :zippy

  #Navigate to the 'Configure tab
  g.config.click
  
  #Login if not called from controller
  g.logn_chk(g.equipinfo,excel[1])

  row = 2
  ws = wb.Worksheets('Tables')
  while(row <= rows+1)
    ws.Range("#{ACTUAL_COLUMN}#{row}").Value = g.det.table(:index,
      ws.Range("#{TABLE_NUMBER_COLUMN}#{row}").Value).text
    row += 1
  end

  f = Time.now  #finish time
#Capture error if any in the script
rescue Exception => e
  f = Time.now  #finish time
  puts" \n\n **********\n\n #{$@ } \n\n #{e} \n\n ***"
  error_present=$@.to_s

ensure #this section is executed even if script goes in error
  if(error_present == nil)
    # If roe > 0, script is called from controller
    # If roe = 0, script is being ran independently
    #Close and save the spreadsheet and thes web browser.
    g.tear_down_d(excel[0],s,f,roe)
    if roe == 0
      $ie.close
    end
  else
    puts" There were errors in the script"
    status = "script in error"
    wb.save
    wb.close
  end
end