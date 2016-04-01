require 'micro-optparse'
require './xml_parser'

options = Parser.new do |p|

  p.banner = 'This is script for convertin XML from 4 to 8'
  p.version = 'alpha'

  # p.option :file, 'path to XML file to parse only one file.', :default => 'String'
  # p.option :folder, 'path to folder with XML files to parse all files.', :default => 'String'
  p.option :input, 'path to single XML file or folder with XML files to parse all files.', :default => 'String'

end.process!

if Dir.exist?(options[:input])
  # run for folder
  convert_all_in_folder options[:input]

elsif File.exist?(options[:input])
  # run as single file

else
  raise 'No such file or folder found: ' + options[:input]

end



# puts options[:input]
# puts Dir.pwd + '/' + options[:input]
# puts Dir.exist?(Dir.pwd + '/' + options[:input])
# puts File.exist?(Dir.pwd + '/' + options[:input])