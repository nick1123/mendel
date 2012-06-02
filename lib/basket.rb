class Basket
  PROCESS_INPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/processed.tsv')
  def initialize(size=2)
    @size = size
    @solutions = []
    load_test_data
    generate_solutions
  end
  
  def run
    run_iteration
  end

  def load_test_data
    @test_data = []
    lines = IO.readlines(PROCESS_INPUT_PATH)
    # Remove header
    lines.shift
    lines[0..3].each do |line|
      day_hash = {:data => {}, :results => {}}
      pieces = line.strip.split("\t")
      
      # PrOpen	PrHigh	PrLow	PrClose PrVol	
      day_hash[:data][:PrOpen]  = pieces[1]
      day_hash[:data][:PrHigh]  = pieces[2]
      day_hash[:data][:PrLow]   = pieces[3]
      day_hash[:data][:PrClose] = pieces[4]
      day_hash[:data][:PrVol]   = pieces[5]
      
      # BuySell	Delta
      day_hash[:results][:BuySell] = pieces[6]
      day_hash[:results][:Delta]   = pieces[7]

      next if day_hash[:results][:BuySell].nil?

      @test_data << day_hash
    end

    puts @test_data
  end
  
  def run_iteration
    @solutions.each do |solution|
      @test_data.each do |day_hash|
        solution.score(day_hash)
      end
    end
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