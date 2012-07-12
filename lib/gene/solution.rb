module Gene
  class Solution
    def initialize(tree=nil)
      @tree = (tree.nil? ? Tree.new : tree)
      @score = nil
    end
    
    def build_expression
      return @tree.exp
    end
    
    def build_score(data_array)
      @score = 0
      begin
        exp = build_expression
        data_array.each do |hash|
          exp_changed = exp.clone
          hash[:inputs].each do |variable, replacement_value|
            exp_changed = exp_changed.gsub(variable, replacement_value.to_s)
            
            expected = hash[:output]
            actual = nil

            eval("actual = #{exp_changed}")
            @score += (actual - expected) ** 2
          end
        end
      rescue ZeroDivisionError => e
        @score = nil
      end      
    end
    
    def to_s
      return "s: #{@score}\t #{@tree.to_s}"
    end
  
    def full
      return "s: #{@score}\t #{@tree.full}"
    end
  
  end
end