module Gene
  class Solution
    def initialize(tree=nil)
      @tree = (tree.nil? ? Tree.new : tree)
      @score = nil
    end
    
    def build_expression
      return @tree.to_s
    end
    
    def build_score(data_array=nil)
      # model x**2
      data_array = [
        {:inputs => {'VAL_N' => 2}, :output => 4},
        {:inputs => {'VAL_N' => 3}, :output => 9},
        {:inputs => {'VAL_N' => 4}, :output => 16},
        {:inputs => {'VAL_N' => 5}, :output => 25},
        {:inputs => {'VAL_N' => 6}, :output => 36}
      ]
      
      @score = 0
      exp = build_expression
      data_array.each do |hash|
        puts hash
        exp_changed = exp.clone
        hash[:inputs].each do |variable, replacement_value|
          exp_changed = exp_changed.gsub(variable, replacement_value.to_s)
          
          expected = hash[:output]
          actual = nil
          eval("actual = #{exp_changed}")
          @score += (actual - expected) ** 2
        end
      end
      
      puts "score: #{@score}"
    end
    
    def to_s
      @tree.to_s
    end
  end
end