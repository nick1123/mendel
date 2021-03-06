class ProcessRawInput
  RAW_INPUT_DIR = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/raw')
  PROCESS_INPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/processed.tsv')
  MAX_SMA = 20
  def self.run
    lines = load_file
    # Remove the header
    lines.shift
    lines.reverse!

    header = ["Date", "PrOpen", "PrHigh", "PrLow", "PrClose", "PrVol", "BuySell", "Delta"]
    (2..MAX_SMA).each do |size|
      header << "SMA_#{size}"
    end
    
    lines_new = []
    lines_new << header.join("\t")
    previous_day_hash = {}
    lines.each do |line|
      day_hash = parse_line(line, previous_day_hash)
      row = []
      row << day_hash[:date]
      row << day_hash[:pr_open]
      row << day_hash[:pr_high]
      row << day_hash[:pr_low]
      row << day_hash[:pr_close]
      row << day_hash[:pr_vol]
      row << day_hash[:buy_or_sell]
      row << day_hash[:delta]

      (2..MAX_SMA).each do |size|
        row << day_hash["sma_#{size}".to_sym]
      end

      previous_day_hash = day_hash
      lines_new << row.join("\t")
    end


    File.open(PROCESS_INPUT_PATH, 'w') {|f| f.write(lines_new.join("\n"))}
  end


  def self.load_file
    return IO.readlines(File.join(RAW_INPUT_DIR, '/original.csv'))
  end

  def self.parse_line(line, previous_day_hash)
    price_divisor = 10_000.0
    round = 6
    pieces = line.split(',')
    day_hash = {}
    day_hash[:date] = pieces[0]

    day_hash[:open]  = (pieces[1].to_f / price_divisor).round(round)
    day_hash[:high]  = (pieces[2].to_f / price_divisor).round(round)
    day_hash[:low]   = (pieces[3].to_f / price_divisor).round(round)
    day_hash[:close] = (pieces[4].to_f / price_divisor).round(round)
    day_hash[:vol]   = (pieces[5].to_f / 1_000_000_000).round(round).to_s
    
    day_hash[:pr_open]  = previous_day_hash[:open]
    day_hash[:pr_high]  = previous_day_hash[:high]
    day_hash[:pr_low]   = previous_day_hash[:low]
    day_hash[:pr_close] = previous_day_hash[:close]
    day_hash[:pr_vol]   = previous_day_hash[:vol]
    
    
    day_hash[:delta] = ""
    day_hash[:buy_or_sell] = ""

    if day_hash[:pr_close]
      day_hash[:delta] = ((day_hash[:close].to_f - day_hash[:pr_close].to_f) * price_divisor).round(round).to_s
      day_hash[:buy_or_sell] = (day_hash[:delta].to_f > 0 ? "BUY" : "SELL")
    
      day_hash[:sma] = previous_day_hash[:sma] 
      day_hash[:sma] ||= {}
    
      (2..MAX_SMA).each do |sma_size|
        day_hash[:sma][sma_size] ||= []
        day_hash[:sma][sma_size] << day_hash[:pr_close].to_f
      
        if day_hash[:sma][sma_size].size > sma_size
          day_hash[:sma][sma_size] = day_hash[:sma][sma_size][(-1 * sma_size)..-1]
        end
      
        avg = average(day_hash[:sma][sma_size])
        day_hash["sma_#{sma_size}".to_sym] = avg.round(round)
      end
    end

    # date = Date.strptime(results[:date], '%Y-%m-%d')
    # day_hash[:day_mon] = date.day
    # day_hash[:mon] = date.mon
    # day_hash[:day_week] = date.wday

    return day_hash
  end
  
  def self.average(arr)
    return (arr.inject(0.0) { |sum, el| sum + el }) / arr.size
  end


end