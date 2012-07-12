require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/lib/gene/*.rb'].each {|file| require file }

# tree = Gene::Tree.new
# puts tree
# puts "****"
# node = tree.random_node
# puts node
# puts node.signature

solution = Gene::Solution.new
puts solution
puts solution.build_score
