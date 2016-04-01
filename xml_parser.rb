require 'nokogiri'

xml_input_file = File.open('./input/input_example.xml') if File.exist? './input/input_example.xml'
parsed_xml = Nokogiri::XML(xml_input_file, nil, 'windows-1251', Nokogiri::XML::ParseOptions::DEFAULT_XML)
xml_input_file.close

# changing xsd to J1201008.xsd
puts 'PHASE 1 - changing xsd to J1201008.xsd'

parsed_xml.xpath('//DECLAR').attr('xsi:noNamespaceSchemaLocation', 'J1201008.xsd')


# save file
File.open("./output/output_example_1.xml", 'w') { |f| f.write parsed_xml }

# see http://stackoverflow.com/questions/5459832/how-can-i-make-empty-tags-self-closing-with-nokogiri

puts 'PHASE 2 - changing C_DOC_VER from 4 to 8'

parsed_xml.xpath('//DECLAR//DECLARHEAD//C_DOC_VER').first.content = 8

# save file
File.open("./output/output_example_2.xml", 'w') { |f| f.write parsed_xml }

puts 'PHASE 3 - changing RXXXXG7 node to RXXXXG010 for each such node'

parsed_xml.xpath('//DECLAR//DECLARBODY//RXXXXG7').each do |node|
  node.name = 'RXXXXG010'
end

# save file
File.open("./output/output_example_3.xml", 'w') { |f| f.write parsed_xml }

puts 'PHASE 4 - changing H10G1S node to HBOS for each such node'

parsed_xml.xpath('//DECLAR//DECLARBODY//H10G1S').each do |node|
  node.name = 'HBOS'
end

# save file
File.open("./output/output_example_4.xml", 'w') { |f| f.write parsed_xml }