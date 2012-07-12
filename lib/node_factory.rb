class NodeFactory
  
  OPERATORS = ['+', '-', '*', '/']
  MAX_DEPTH = 4
  
  def self.build(depth=1)
    return Node.new(operand(depth), operator, operand(depth))
  end
  
  def self.operand(depth)
    op = nil
    if depth <= MAX_DEPTH
      op = ((rand > 0.50) ? random_value : NodeFactory.build(depth+1))
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
  
  def self.operator
    return OPERATORS[rand(OPERATORS.size)]
  end

end