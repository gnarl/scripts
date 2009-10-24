#! /usr/local/bin/ruby

require 'rubygems'
require 'rdiscount'
require 'fileutils'

# The program takes a Markdown document, converts it to HTML, and
# outputs the HTML file to your Dropbox.  
#
# Place this file in your user's bin directory and set appropriate
# permissions if needed.  
#
# The original file is renamed with the same basename and ".html" as
# the extension.  The output file is written to the relative directory
# '../Dropbox/notes/'. 
#
# Author:: Chuck Fouts

SCRIPT_DIR = File.dirname(__FILE__)
OUT_DIR = '../Dropbox/notes/'

filename = ARGV.shift
abort 'Need a filename to process!' unless filename

out_filename = File.basename( filename, File.extname( filename ) ) + ".html"

puts "processing: #{filename}"
text = ""
File.open( filename, 'r').each_line {|x| text << x } 

markdown = RDiscount.new(text)
output =  markdown.to_html

FileUtils.cd( SCRIPT_DIR )
File.open( OUT_DIR + out_filename, 'w' ) { |x| x.puts output }
