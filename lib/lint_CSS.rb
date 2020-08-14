module LintCSS
  
  def file_read
    @file_read = File.read("lint-style.css")
    @file_read
  end

  def take_file_data
    @file_data = file_read
  end

  def bracket_splitter
    @first_bracket = @file_data.split('').values_at(0) 
    @last_bracket = @file_data.split('').values_at(-1)
  end

  def bracket_match_keeper
    @matchs = @file_data.scan(@open_bracket).size + @file_data.scan(@close_bracket).size
  end

  def string_to_array
    split_each_item = @file_data.split(" ")
    split_each_item
  end

  def find_bracket_index
    @indish_open = []
    @indish_close = []
    string_to_array.each_with_index do |x , y|
      if x.match(open_bracket)
          @indish_open << y
          @indish_open
        elsif x.match(close_bracket)
          @indish_close << y
          @indish_close
      end
    end
  end

  def check_fill_or_not
    @indish_open = []
    @indish_close = []
    i = 0
    @indish_open.length.times do
      if @indish_close[i] - @indish_open[i] <= 1
        i += 1
        prompt_message('failed')
        prompt_lint('empty_rule')
        elsif @indish_close[i] - @indish_open[i] >= 2
          i += 1
          prompt_message('passed')
      end
    end
  end

end