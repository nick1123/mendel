require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/lib/gene/*.rb'].each {|file| require file }

# tree = Gene::Tree.new
# puts tree
# puts "****"
# node = tree.random_node
# puts node
# puts node.signature

# solution = Gene::Solution.new
# puts solution
# puts solution.build_score


# model x**2
data_array = [
	{:inputs => {'VAL_N' => 2}, :output => 4},
	{:inputs => {'VAL_N' => 3}, :output => 9},
	{:inputs => {'VAL_N' => 4}, :output => 16},
	{:inputs => {'VAL_N' => 5}, :output => 25},
	{:inputs => {'VAL_N' => 6}, :output => 36}
]

basket = Gene::Basket.new(data_array)
basket.run
# puts basket