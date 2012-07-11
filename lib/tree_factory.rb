class TreeFactory
  def self.build
    # Build Nodes
    
    root_node = NodeFactory.build
    return Tree.new(root_node)
  end
end