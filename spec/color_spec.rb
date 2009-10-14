require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Color" do
  describe "parse_method_name" do
    it "should correctly parse a single color" do
      Color.parse_method_name(:cyan).should == ["cyan", nil, []]
    end
    
    it "should correctly parse a single background color" do
      Color.parse_method_name(:on_red).should == [nil, "red", []]
    end
    
    it "should correctly parse a single formatting option" do
      Color.parse_method_name(:bold).should == [nil, nil, ["bold"]]
    end
    
    it "should correctly parse a foreground color and background color" do
      Color.parse_method_name(:blue_on_green).should == ["blue", "green", []]
      Color.parse_method_name(:on_magenta_yellow).should == ["yellow", "magenta", []]
    end
    
    it "should correctly parse a foreground color and single formatting option" do
      Color.parse_method_name(:red_bold).should == ["red", nil, ["bold"]]
      Color.parse_method_name(:underline_green).should == ["green", nil, ["underline"]]
    end
    
    it "should correctly parse a background color and two formatting options" do
      Color.parse_method_name(:on_red_bold_underline).should == [nil, "red", ["bold", "underline"]]
      Color.parse_method_name(:underline_on_red_bold).should == [nil, "red", ["underline", "bold"]]
    end
    
    it "should correctly parse a foreground color, background color and formatting option" do
      Color.parse_method_name(:blue_on_cyan_bold).should == ["blue", "cyan", ["bold"]]
      Color.parse_method_name(:underline_red_on_green).should == ["red", "green", ["underline"]]
      Color.parse_method_name(:on_magenta_bold_black).should == ["black", "magenta", ["bold"]]
    end
  end
  
  describe "prepare_foreground_color" do
    it "should correctly convert 'blue' into terminal output" do
      Color.send(:prepare_foreground_color, "blue").should == "\e[34m"
    end
    
    it "should correctly handle a nil value" do
      Color.send(:prepare_foreground_color, nil).should == ""
    end
    
    it "should correctly handle a non-existent color" do
      Color.send(:prepare_foreground_color, "turquoise").should == "\e[30m"
    end
  end
  
  describe "prepare_background_color" do
    it "should correctly convert 'magenta' into terminal output" do
      Color.send(:prepare_background_color, "magenta").should == "\e[45m"
    end
    
    it "should correctly handle a nil value" do
      Color.send(:prepare_background_color, nil).should == ""
    end

    it "should correctly handle a non-existent color" do
      Color.send(:prepare_background_color, "pink").should == "\e[40m"
    end
  end
  
  describe "prepare_formatting" do
    it "should correctly convert ['bold'] into terminal output" do
      Color.send(:prepare_formatting, "bold").should == "\e[1m"
    end

    it "should correctly convert ['bold', 'underline'] into terminal output" do
      Color.send(:prepare_formatting, "bold", "underline").should == "\e[1m\e[4m"
    end

    it "should correctly convert [] into terminal output" do
      Color.send(:prepare_formatting, *[]).should == ""
    end

    it "should correctly handle ['fake_formatting_option']" do
      Color.send(:prepare_formatting, "fake_formatting_option").should == "\e[0m"
    end
  end
  
  describe "prepare_string" do
    it "should return the correct value for the parameter set ('hello', 'blue', nil, [])" do
      Color.prepare_string("hello", "blue", nil, []).should == "\e[34mhello\e[0m"
    end
    
    it "should return the correct value for the parameter set ('hello', nil, 'red, [])" do
      Color.prepare_string("hello", nil, "red", []).should == "\e[41mhello\e[0m"
    end

    it "should return the correct value for the parameter set ('hello', 'green', 'red, ['bold])" do
      Color.prepare_string("hello", "green", "red", ["bold"]).should == "\e[32m\e[41m\e[1mhello\e[0m"
    end      


  end
end
