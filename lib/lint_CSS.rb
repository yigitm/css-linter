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

  def find_bracket_index(open_bracket_array =nil , close_bracket_array = nil)
    string_to_array.each_with_index do |character , index|
      if open_bracket_array != nil && character.match(open_bracket) && 
          open_bracket_array << index
        elsif close_bracket_array != nil && character.match(close_bracket)
           close_bracket_array << index
      end
    end
  end

  def check_fill_or_not(open_bracket_array, close_bracket_array)
    @index = 0
    open_bracket_array.length.times do
      if close_bracket_array[@index] - open_bracket_array[@index] <= 1
        @index += 1
        prompt_message('failed')
        prompt_lint('empty_rule')
        elsif close_bracket_array[@index] - open_bracket_array[@index] >= 2
          @index += 1
          prompt_message('passed')
      end
    end
  end

end