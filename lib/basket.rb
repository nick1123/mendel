class Basket
  PROCESS_INPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/processed.tsv')
  def initialize(size=5)
    @size = size
    @solutions = []
    load_test_data
    generate_solutions
  end

  def load_test_data
    @test_data = []
    lines = IO.readlines(PROCESS_INPUT_PATH)
    # Remove header
    lines.shift
    lines.each do |line|
      hsh = {}
      pieces = line.strip.split("\t")
      hsh[:vol] = pieces[1]
      hsh[:close_pr] = pieces[2]
      hsh[:delta] = pieces[3]

      next if hsh[:delta].size == 0
      next if hsh[:close_pr].size == 0

      @test_data << hsh
    end

    puts @test_data
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