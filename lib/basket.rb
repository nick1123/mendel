class Basket
  PROCESS_INPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/processed.tsv')
  OUTPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/output/log.txt')
  
  def initialize(size=1_000)
    @size = size
    @solutions = []
    load_test_data
    generate_random_solutions
  end
  
  def write(data)
    File.open(OUTPUT_PATH, 'a') {|f| f.write(data.to_s + "\n\n")}
  end
  
  def run
    (0..99).each do |i|
      write("** Iteration #{i}")
      puts "** Iteration #{i}"
      run_iteration
    end
  end

  def load_test_data
    @test_data = []
    lines = IO.readlines(PROCESS_INPUT_PATH)
    # Remove header
    lines.shift
    lines.each do |line|
      day_hash = {:data => {}, :results => {}}
      pieces = line.strip.split("\t")
      
      # PrOpen	PrHigh	PrLow	PrClose PrVol	
      day_hash[:data][:PrOpen]  = pieces[1]
      day_hash[:data][:PrHigh]  = pieces[2]
      day_hash[:data][:PrLow]   = pieces[3]
      day_hash[:data][:PrClose] = pieces[4]
      day_hash[:data][:PrVol]   = pieces[5]
      
      # BuySell	Delta
      day_hash[:results][:Direction] = pieces[6]
      day_hash[:results][:Delta]     = pieces[7]
      
      (2..ProcessRawInput::MAX_SMA).each_with_index do |sma_size, index|
        day_hash[:data]["SMA_#{sma_size}".to_sym] = pieces[8 + index]
      end

      next if day_hash[:results][:Direction].nil?

      @test_data << day_hash
    end
  end
  
  def solutions_abbrev
    (@solutions.map {|s| s.to_s_abbrev})[0..9].join("\n")
  end
  
  def solutions_full
    (@solutions.map {|s| s.to_s}).join("\n")
  end
  
  def run_iteration
    run_test_data
    sort_solutions
    best_solutions
    calc_convergence

    puts "**********************************************************"
    puts solutions_abbrev
    puts "Conv: #{@convergence}"

    write("**********************************************************")
    write(solutions_full)
    write("Conv: #{@convergence}")

    cross_best_solutions
    mutate_best_solutions    
    generate_random_solutions    
  end
  
  def run_test_data
    @solutions.each do |solution|
      solution.increment_life_cycle_count
      next if solution.frozen?
      @test_data.each do |day_hash|
        solution.score(day_hash)
      end
      
      solution.freeze      
    end    
  end
    
  def sort_solutions
    @solutions = @solutions.sort {|a,b| b.profit <=> a.profit}    
  end
  
  def best_solutions
    @solutions = @solutions[0..(@size/4 -1)]
    @best_solutions = @solutions.map {|s| s.copy}
  end
  
  def calc_convergence
    best  = @best_solutions[0].profit
    worst = @best_solutions[-1].profit
    @convergence = ((best - worst) / best).round(3)    
  end
  
  def cross_best_solutions
    @best_solutions.each do |solution|
      index = rand(@best_solutions.size)
      solution2 = @best_solutions[index]
      next if solution.eq?(solution2)
      new_solution = solution.cross(solution2)
      next if solution.eq?(new_solution)
      next if solution2.eq?(new_solution)
      @solutions << new_solution
    end
  end

  def mutate_best_solutions
    @best_solutions.each do |solution|
      new_solution = solution.mutate
      next if solution.eq?(new_solution)
      @solutions << new_solution
    end    
  end
  
  def generate_random_solutions
    while @solutions.size < @size
      @solutions << Solution.new
    end
  end

  def to_s
    @solutions.join("\n")
  end


end