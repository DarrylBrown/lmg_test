=begin
Change the test_site in the windows host file
The new ip is passed as a command line argument
  example: chng-test_site.rb 1.2.3.4

A regex matches the line that contains an 'ip' AND 'test-site'
The file stream is opened and read the match is found and replaced.
The stream is then rewound (rewind) and written (puts) back to file. 

Reason for the puts '    ' 
If the new ip char length is less than previous 
  i.e. 1.2.3.4 -vs- 10.20.30.40
  then the last char in file are re-written
  these spaces will overwrite any added chars.
  May need to find a beeter way to handle this as the 
  as the file will progessively get longer each time this script is ran.
  
The file is automatically saved.
=end



host = 'C:/WINDOWS/system32/drivers/etc/hosts'
ip = ARGV[0].dup
old = /(\d{1,}\.\d{1,}\.\d{1,}\.\d{1,})(\s+)(test_site)/
new = ip << "    " << 'test_site'

File.open(host,'r+') do|f| newfile = 
    f.read.gsub(old, new)
    f.rewind 
    f.puts(newfile)
    f.puts'   ' 
  end           