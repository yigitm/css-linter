module Lintcss
  def file_select
    @file_list = ['test_files/lint-bracket-no.css', 'test_files/lint-bracket-missing.css', 'test_files/lint-empty-rule.css',
                  'test_files/lint-important.css', 'test_files/lint-dry.css', 'test_files/lint-property.css']
    input = @selected_file
    @file_list.each do |file|
      @file_list[input.to_i - 1] if @file_list.index(file).to_i == input.to_i - 1
    end
    @file_list[input.to_i - 1]
  end

  def file_read
    @file_read = File.read(file_select.to_s)
    @file_read
  end

  def take_file_data
    @file_data = file_read
    @file_data
  end

  def bracket_splitter
    @first_bracket = @file_data.split('').values_at(0)
    @last_bracket = @file_data.split('').values_at(-1)
  end

  def bracket_match_keeper
    @matchs = @file_data.scan(@open_bracket).size + @file_data.scan(@close_bracket).size
  end

  def string_to_array
    split_each_item = @file_data.split(' ')
    split_each_item
  end

  def compare_bracket_length
    if find_same_brackets('{').length == find_same_brackets('}')
      true
    elsif find_same_brackets('{').length != find_same_brackets('}')
      false
    end
  end

  def begin_end_bracket_checker
    string_to_array.each_with_index do |character, _index|
      true if character.match('{') && character.match('}')
    end
  end

  def bracket_even_checker
    if compare_bracket_length
      prompt_message('passed')
    elsif bracket_no_checker
      prompt_message('failed')
      prompt_lint_error('no_brackets')
    else
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
    end
  end

  def bracket_odd_checker
    if matchs.odd?
      true if begin_end_bracket_checker
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
    elsif bracket_no_checker
      prompt_message('failed')
      prompt_lint_error('no_brackets')
    end
  end

  def bracket_no_checker
    true if matchs.zero? || matchs.nil?
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
    scanned_array = take_file_data.scan(regex_variable)
    scanned_array
  end

  def find_length_difference(array_one, array_two)
    result = array_one.length - array_two.length
    result
  end
end
