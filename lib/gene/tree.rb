module Gene
    class Tree
  
    def initialize
      @root_node = NodeFactory.build
    end

    def random_node
      list = @root_node.node_list.flatten
      return list[rand(list.size)]
    end
  
    def to_s
      return @root_node.to_s
    end
  end
end