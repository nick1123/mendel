class Tree
  
  def initialize(root_node)
    @root_node = root_node
    @node_hash = root_node.node_hash
  end
  
  def to_s
    return self.object_id
  end
end