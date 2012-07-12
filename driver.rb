require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

tree = Tree.new
puts tree
puts "****"
node = tree.random_node
puts node
puts node.signature