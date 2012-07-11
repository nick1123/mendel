require 'spec_helper'

describe ProcessRawInput do
  context "load_file" do
    it "should do stuff" do
      lines = ProcessRawInput.load_file
      lines.size.should eq 281
    end
  end
  
  context "parse line" do
    it "should parse a line with no previous day" do 
      line = "2012-02-10,12889.55,12889.55,12712.26,12801.23,3877580000,12801.23"
      results = ProcessRawInput.parse_line(line)
      results.class.should eq Hash
      results[:date].should eq "2012-02-10"
      results[:close].should eq "12801.23"
      results[:volume_millions].should eq "3878"
      results[:close_delta].should be_nil
    end

    it "should parse a line with 1 previous day" do 
      line = "2012-02-10,12889.55,12889.55,12712.26,12801.23,3877580000,12801.23"
      previous_day_close = "12401.22"
      results = ProcessRawInput.parse_line(line, previous_day_close)
      results.class.should eq Hash
      results[:date].should eq "2012-02-10"
      results[:close].should eq "12801.23"
      results[:volume_millions].should eq "3878"
      results[:close_delta].should eq "400.01"
    end
  end
end

