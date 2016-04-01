require 'nokogiri'

def convert_xml(xml_input_file)

  parsed_xml = Nokogiri::XML(xml_input_file, nil, 'windows-1251', Nokogiri::XML::ParseOptions::DEFAULT_XML)


# changing xsd to J1201008.xsd
  puts 'PHASE 1 - changing xsd to J1201008.xsd'

  parsed_xml.xpath('//DECLAR').attr('xsi:noNamespaceSchemaLocation', 'J1201008.xsd')


# see http://stackoverflow.com/questions/5459832/how-can-i-make-empty-tags-self-closing-with-nokogiri

  puts 'PHASE 2 - changing C_DOC_VER from 4 to 8'

  parsed_xml.xpath('//DECLAR//DECLARHEAD//C_DOC_VER').first.content = 8


  puts 'PHASE 3 - changing RXXXXG7 node to RXXXXG010 for each such node'

  parsed_xml.xpath('//DECLAR//DECLARBODY//RXXXXG7').each do |node|
    node.name = 'RXXXXG010'
  end


  puts 'PHASE 4 - changing H10G1S node to HBOS for each such node'

  parsed_xml.xpath('//DECLAR//DECLARBODY//H10G1S').each do |node|
    node.name = 'HBOS'
  end


# puts 'PHASE 5 - verifying by XSD'
#
# xsd = Nokogiri::XML::Schema(File.read('./xsds/J1201008.xsd'))
#
# xsd.validate(parsed_xml).each do |error|
#   puts error.message
# end
  return parsed_xml

end


def convert_single_file(file_path)

  puts 'Reading file: ' + file_path
  xml_input_file = File.open(file_path) if File.exist? file_path

  puts 'Started converting for ' + file_path

  converted_xml = convert_xml xml_input_file

  puts "Saving to /output/#{File.basename(file_path)} "

  Dir.mkdir './output' if !Dir.exist?  'output'

  File.open("./output/#{File.basename(file_path)}", 'w') { |f| f.write converted_xml }

  xml_input_file.close


end

def convert_all_in_folder(folder_path)

  Dir.entries(folder_path).each do |file|
    convert_single_file(folder_path + '/' + file )unless File.directory?(file)
  end

end

convert_all_in_folder('./input')