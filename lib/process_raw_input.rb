class ProcessRawInput
  RAW_INPUT_DIR = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/raw')
  PROCESS_INPUT_PATH = File.join(File.expand_path(File.dirname(__FILE__)), '../flat_files/inputs/processed.tsv')
  def self.run
    lines = load_file
    # Remove the header
    lines.shift

    lines_new = []
    lines_new << ["Date", "Vol", "ClosePr", "Delta", "Close", "DayMon", "Month", "DayWk"].join("\t")
    previous_day_close = nil
    lines.each do |line|
      results = parse_line(line, previous_day_close)
      previous_day_close = results[:close]
      row = []
      row << results[:date]
      row << results[:volume_millions]
      row << results[:close_prev]
      row << results[:delta]
      row << results[:close]
      row << results[:day_mon]
      row << results[:mon]
      row << results[:day_week]

      lines_new << row.join("\t")
    end


    File.open(PROCESS_INPUT_PATH, 'w') {|f| f.write(lines_new.join("\n"))}
  end


  def self.load_file
    return IO.readlines(File.join(RAW_INPUT_DIR, '/original.csv'))
  end

  def self.parse_line(line, previous_day_close=nil)
    pieces = line.split(',')
    results = {}
    results[:date] = pieces[0]
    date = Date.strptime(results[:date], '%Y-%m-%d')

    results[:close] = pieces[4]
    results[:volume_millions] = (pieces[5].to_i / 1_000_000.0).round.to_s
    results[:close_prev] = ""
    results[:delta] = ""
    results[:day_mon] = date.day
    results[:mon] = date.mon
    results[:day_week] = date.wday

    # Time.parse("#{results[:date]} 00:00:00 -0000")

    if previous_day_close
      results[:close_prev] = previous_day_close
      results[:delta] = (results[:close].to_f - previous_day_close.to_f).round(2).to_s
    end

    return results
  end


end