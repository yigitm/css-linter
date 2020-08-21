require 'colorize'
module Lintcss
  def which_default_file?
    @file_list = ['test_files/lint-bracket-no.css', 'test_files/lint-bracket-missing.css', 'test_files/lint-empty-rule.css',
                  'test_files/lint-important.css', 'test_files/lint-dry.css', 'test_files/lint-property.css']
    @file_list.each do |file| 
        if @file_list.index(file).to_i == @selected_file.to_i - 1
          @selected_file = @file_list[@selected_file.to_i - 1]
        end
    end
  end

  def string_to_array
    split_each_item = file_read.split(' ')
    split_each_item
  end
  
  def find_same_brackets(bracket_type)
    bracket_array = []
    string_to_array.each_with_index do |character, index|
      bracket_array << index if character.match(bracket_type)
    end
    bracket_array
  end

  def check_fill_or_not(indish_open, indish_close)
    l = (indish_open.length + indish_close.length) / 2
    i = 0
    l.times do
      if indish_close[i] - indish_open[i] <= 1
        i += 1
        return true
      elsif indish_close[i] - indish_open[i] >= 2
        i += 1
        return false
      end
    end
  end

  def regex_scanner(regex_variable)
    scanned_array = file_read.scan(regex_variable)
  end

  def find_length_difference(array_one, array_two)
    result = array_one.length - array_two.length
  end
end
