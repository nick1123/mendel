class ExpressionBuilder
  def self.gen
    file_contents = IO.read("flat_files/inputs/variable_list.txt")
    variables = file_contents.strip.split(/\s+/)
    return (variables.map {|var| build_piece(var)}).join(' * ')
  end

  def self.build_piece(var)
    power = sign + (1 + rand).round(2).to_s
    return "( #{var} ** #{power} )"
  end


  def self.coin_toss
    (rand > 0.5 ? true : false)
  end

  def self.sign
    (coin_toss ? '-' : '')
  end


end