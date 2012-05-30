class Basket
  def initialize(size=5)
    @size = size
    @solutions = []
    generate_solutions
  end
  
  def generate_solutions
    while @solutions.size < @size
      @solutions << Solution.new
    end
  end
  
  def to_s
    @solutions.join("\n")
  end
  
  
end