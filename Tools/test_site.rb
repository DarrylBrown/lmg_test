=begin
**This program assumes that test_site already exists in the host file**

1) Read the the host file and show existing test_site (ip1) address.
2) Keep existing address by pressing <Enter> or type new address and <Enter>
3) If new address (ip2) is entered, validate and then write to host file.
4) Show the test_site IP address that will be used

=end

# Initialize variables
host = 'C:/WINDOWS/system32/drivers/etc/hosts'
valid_ip = /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/
testsite = /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s+(test_site)/
ip1 = nil
ip2 = nil

File.open(host).each do|line|
  if line =~ testsite 
    ip1 = $1  # $1 is the group in the valid_ip regex
    print "Existing test_site IP address is: ",ip1
  end
end

puts "\n\nTo keep the existing IP address, press <Enter>"
print "-OR- Type new IP address followed by <Enter>: "

ip2 = gets.chomp
if ip2 != ''
  while ip2 !~ valid_ip
    print "\nPlease type a valid IP address followed by <Enter>: "
    ip2 = gets.chomp
  end
  new = "#{ip2}" << "    " << 'test_site'
  File.open(host,'r+') do|f| newfile =
      f.read.gsub(testsite, new)
      f.rewind
      f.puts((newfile).strip)
      f.puts '        '
      puts "\nNew test_site IP address is: #{ip2}"
  end
else
  puts "\nKeeping existing test_site IP address: #{ip1}"
end

puts "\nDone"
