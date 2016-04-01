# convert-xml
convert-xml

Just for convert imput XML to required output with new format.

### How to setup

* [Install Git for Windows](https://git-scm.com/download/win)
* [install Ruby v2.0](http://rubyinstaller.org/downloads/)
* Clone from git repository:
 
    `git clone https://github.com/Jenyaya/convert-xml.git`
* Change directory on convert-xml
* Install bundler:
 
    `gem install bundler`
* Install gems:
 
    `bundle install`


### How to use
* You can use help:

 `ruby convert_xmls.rb --help`

* Run for file by file path:

`ruby convert_xmls.rb --input '\<file_path>\input_example.xml'`

* Run for all XML files in folder:

`ruby convert_xmls.rb --input '\<file_path>\'`

* Results you will get in ./output folder
