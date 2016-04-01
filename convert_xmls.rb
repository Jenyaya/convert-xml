require 'micro-optparse'
require './xml_parser'

options = Parser.new do |p|

  p.banner = 'This is script for converting XML'
  p.version = 'alpha'
  p.option :input, 'path to single XML file or folder with XML files to parse all files.', :default => 'String'

end.process!

if Dir.exist?(options[:input])
  # run for folder
  convert_all_in_folder options[:input]

elsif File.exist?(options[:input])
  # run as single file
  convert_single_file options[:input]
else
  raise 'No such file or folder found: ' + options[:input]
end
