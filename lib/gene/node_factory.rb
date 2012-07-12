module Gene
  class NodeFactory
  
    OPERATORS = ['+', '-', '*', '/']
    MAX_DEPTH = 8
    CHANCE_NEW_LEVEL = 0.5
  
    def self.build(depth=1)
      return Node.new(build_operand(depth), build_operator, build_operand(depth))
    end
  
    def self.build_operand(depth)
      op = nil
      if depth <= MAX_DEPTH
        op = ((rand > CHANCE_NEW_LEVEL) ? random_value : NodeFactory.build(depth+1))
      else
        op = random_value
      end

      return op
    end

    def self.random_value
      value = (rand > 0.5 ? rand(100) : 'VAL_N').to_s
      value = "-#{value}" if rand > 0.5
      return value
    end
  
    def self.build_operator
      return OPERATORS[rand(OPERATORS.size)]
    end

  end
end