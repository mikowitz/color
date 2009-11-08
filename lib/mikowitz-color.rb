module Color
  COLORS = {
    "black" => 0,
    "red" => 1,
    "green" => 2,
    "yellow" => 3,
    "blue" => 4,
    "magenta" => 5,
    "cyan" => 6,
    "white" => 7
  }
  COLORS.default = 0

  FORMATS = {
    "bold" => 1,
    "underline" => 4
  }
  FORMATS.default = 0
  
  def self.io; $stderr; end
  
  def self.method_missing(method, string, newline=true)
    io.write prepare_string(string, *parse_method_name(method))
    io.flush
    puts if newline
  end
  
  def self.prepare_string(string, foreground=nil, background=nil, formatting=[])
    [ prepare_foreground_color(foreground),
      prepare_background_color(background),
      prepare_formatting(*formatting),
      string,
      "\e[0m"
    ].join("")
  end
  
  def self.parse_method_name(name)
    name = name.to_s.split("_")
    if x = name.index("on")
      name.delete("on")
      background = name.delete_at(x)
    end
    foreground = name.find{|b| COLORS.keys.include?(b) }
    formatting = name.reject{|b| COLORS.keys.include?(b) }
    [foreground, background, formatting]
  end
  
  private
    def self.prepare_foreground_color(color=nil)
      handle_color(3, color)
    end
    
    def self.prepare_background_color(color=nil)
      handle_color(4, color)
    end
    
    def self.prepare_formatting(*formats)
      return "" if formats.empty?
      formats.map{|f| "\e[#{FORMATS[f]}m"}.join("")
    end
    
    def self.handle_color(lead, color=nil)
      return "" unless color
      "\e[#{lead}#{COLORS[color]}m"
    end
end