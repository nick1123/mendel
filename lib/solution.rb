class Solution

  def initialize
    @expression = ExpressionBuilder.gen
    @profit = 0.0
  end

  def copy
  end

  def score(day_hash)
    # day_hash[:data][:PrOpen]  = pieces[1]
    # day_hash[:data][:PrHigh]  = pieces[2]
    # day_hash[:data][:PrLow]   = pieces[3]
    # day_hash[:data][:PrClose] = pieces[4]
    # day_hash[:data][:PrVol]   = pieces[5]
    # 
    # day_hash[:results][:BuySell] = pieces[6]
    # day_hash[:results][:Delta]   = pieces[7]
    new_expression = @expression.to_s
    puts "*****"
    puts day_hash
    puts @expression
    day_hash[:data].each do |var, value|
      new_expression = new_expression.gsub(var.to_s, value)
    end
    
    puts new_expression
    puts @expression
    
    total = 0.0
    eval_expression = "total = (#{new_expression}).round(3)"
    puts eval_expression
    eval(eval_expression)
    puts total
    puts ""
    
  end

  def mutate
  end

  def to_s
    @expression
  end

end