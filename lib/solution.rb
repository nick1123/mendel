class Solution

  def initialize
    @expression = ExpressionBuilder.gen
    @profit = 0.0
  end

  def copy
  end

  def score
  end

  def mutate
  end

  def to_s
    @expression
  end

end