=begin
#------------------------------------------------------------------------------#
A short script that will return a list of test cases recursively in a given
path.
#------------------------------------------------------------------------------#
=end

require 'find'
require 'nokogiri'

dirs = ['I:\lmg test engineering\TestLog\Projects\Configuration Test Cases\Project Test Cases\700. Configure']
excludes = []

for dir in dirs
  Find.find(dir) do |path|
    if FileTest.directory?(path)
      if excludes.include?(File.basename(path))
        Find.prune       # Don't look any further into this directory.
      else
        next
      end
    else
      if path =~ /\.tlg/
        print File.basename(path).sub('.tlg','') + ','
        xml = Nokogiri::XML(File.open(path))
        puts xml.xpath("//test_title").text
      end
    end
  end
end
