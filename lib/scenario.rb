class Scenario
  def initialize
    @basket = Basket.new
    puts @basket
    
  end
  
  def run
    @basket.run
  end
end