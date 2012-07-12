require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

# opts = Trollop::options do
#   opt :raw_input_processing, "Process raw input files into a stardard form"
#   opt :generate_function, "Generate function"
# end
# 
# if opts[:raw_input_processing]
#   ProcessRawInput.run
# end
# 
# if opts[:generate_function]
#   scenario = Scenario.new
#   scenario.run
# end


tree = Tree.new
puts tree
puts "****"
puts tree.random_node.inspect