module Gene
	class Basket
		def initialize(data_array, count=30)
      @data_array = data_array
      @solution_count = count
      reset
    end

    def run
      @solutions.each {|s| s.build_score(@data_array)}
    end

    def reset
      @solutions = []
      @solution_count.times do 
        @solutions << Gene::Solution.new
      end
    end

    def to_s
      (@solutions.map {|s| s.to_s}).join("\n")
    end

    def full
      (@solutions.map {|s| s.full}).join("\n")
    end

  end
end