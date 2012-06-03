require 'digest/md5'

class Solution
  
  attr_reader :profit, :expression
  
  EXPONENT_ROUND = 2
  DELIM = ' * '
  
  RANDOM = 'RA'
  MUTANT = 'MU'
  CROSS  = 'CR'

  def initialize(expression=nil, origin=RANDOM, profit=0)
    @expression = (expression.nil? ? ExpressionBuilder.gen : expression.to_s)
    @profit = profit
    @origin = origin
    @signature = Digest::MD5.hexdigest(@expression)
    @life_cycle_count = 0
    @frozen = false
    @win = 0
    @loss = 0
  end
  
  def copy
    return Solution.new(@expression, @orign, @profit)
  end
  
  def frozen?
    return @frozen
  end
  
  def freeze
    @frozen = true
  end
  
  def eq?(solution)
    return (@expression == solution.expression)
  end

  def cross(solution)
    pieces_a = solution.expression.split(DELIM)
    pieces_b = @expression.split(DELIM)
    new_expression = []
    (0..(pieces_a.size - 1)).each do |index|
      new_expression << (rand > 0.5 ? pieces_a[index] : pieces_b[index])
    end
    
    new_solution = Solution.new(new_expression.join(DELIM), CROSS)
    return new_solution
  end

  def score(day_hash)
    new_expression = @expression.to_s

    day_hash[:data].each do |var, value|
      new_expression = new_expression.gsub(var.to_s, value)
    end
        
    direction = nil
    eval_expression = "direction = ((#{new_expression}) > 1 ? 'BUY' : 'SELL')"
    eval(eval_expression)

    delta = day_hash[:results][:Delta].to_f.abs
    if direction == day_hash[:results][:Direction]
      @win += 1
      @profit += delta
    else
      @loss += 1
      @profit -= delta
    end
  end
  
  def increment_life_cycle_count
    @life_cycle_count += 1
  end

  def mutate
    pieces = @expression.split(/\s+/)
    new_expression = (pieces.map {|str| mutate_piece(str)}).join(" ")
    return Solution.new(new_expression, MUTANT)
  end
  
  def mutate_piece(str)
    return str unless is_numeric?(str)
    return str unless rand > 0.5
    return (str.to_f * mutation_factor).round(EXPONENT_ROUND).to_s
  end

  def mutation_factor
    factor = 1 + rand
    factor = (1 / factor) if rand > 0.5
    # factor = 0 if rand < 0.1
    return factor
  end
  
  def is_numeric?(str)
    return (str.to_f.to_s == str)
  end
  
  def win_percent
    ((100.0 * @win) / (@win + @loss)).round
  end

  def to_s
    "#{@signature[0..4]}  #{@origin}  LC: #{@life_cycle_count}  W%: #{win_percent} (#{@win}/#{@loss})  P: #{@profit.round(2)}  #{@expression}"
  end

end