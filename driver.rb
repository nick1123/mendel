require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

opts = Trollop::options do
  opt :raw_input_processing, "Process raw input files into a stardard form"
end