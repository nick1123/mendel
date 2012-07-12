require 'digest/md5'

module Gene
  class Node
    def initialize(operand1, operator, operand2)
      @operand1 = operand1
      @operator = operator
      @operand2 = operand2
    end

    def node_list
      list = [self]
      list << @operand1.node_list if @operand1.is_a?(Node)
      list << @operand2.node_list if @operand2.is_a?(Node)
      return list
    end
  
    def exp
      return "(#{@operand1} #{@operator} #{@operand2})"
    end

    def to_s
      return exp
    end

  end
end