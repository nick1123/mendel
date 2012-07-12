module Gene
  class Tree
    def initialize
      @root_node = NodeFactory.build
    end

    def random_node
      list = @root_node.node_list.flatten
      return list[rand(list.size)]
    end
  
    def exp
      return @root_node.exp
    end

    def full
      return "#{signature} #{exp}"
    end

    def to_s(max=80)
      str = "#{signature[0..3]} #{exp}"
      if str.size > max
        str = str[0..(max-4)] + '...'
      end

      return str
    end

    def signature
      Digest::MD5.hexdigest(exp)
    end


  end
end