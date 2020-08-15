require_relative '../lib/prompter.rb'
class Linters < Prompter
include LintCSS
attr_reader :file_data,:open_bracket,:close_bracket,
:first_bracket,:last_bracket,:matchs,:indish_open,:indish_close,:dry_array
  def initialize
    @file_data = file_data
    @open_bracket = (/{/)
    @close_bracket = (/}/)
    @first_bracket = first_bracket
    @last_bracket = last_bracket
    @matchs = matchs
    @indish_open = indish_open
    @indish_close = indish_close
    @dry_array = dry_array
  end

    def bracket_checker
      take_file_data
      bracket_match_keeper
      bracket_splitter
      if matchs.even? && matchs != 0
        prompt_message('passed')
      elsif matchs.odd? == true && matchs != 0
        prompt_message('failed')
        prompt_lint('missing_brackets')
      elsif matchs == 0
        prompt_message('failed')
        prompt_lint('no_brackets')
      elsif first_bracket == ['{'] && last_bracket == ['}'] && matchs.odd?
        prompt_message('failed')
        prompt_lint('missing_brackets')
      end
    end

    def empty_rule_checker
      take_file_data
      indish_open = find_bracket_index(open_bracket)
      indish_close = find_bracket_index(close_bracket)
      message = check_fill_or_not(indish_open, indish_close)
      if message == true
        prompt_message('failed')
        prompt_lint('empty_rule')
      else
        prompt_message('passed')
      end
    end

    def important_tag_checker
      count_important = take_file_data.scan("!important").size
      case count_important
      when (0..9)
        prompt_message('passed')
      when (10..file_data.size)
        prompt_message('failed')
        prompt_lint('!important')
      else
        false
      end
    end

    def dry_violation_checker
      take_file_data
      dry_array = take_file_data.scan(/\S*\w*\s\W*\w*;/)

      if dry_array == dry_array.uniq
        prompt_message('passed')
      else
        prompt_message('failed')
        prompt_lint('dry_violation')
      end
    end

    def property_name_checker
      take_file_data
      dry_array = regex_scanner(/\S*\w*\s\W*\w*;/)
      property_array = regex_scanner(/\S*\w*:/)

      if dry_array.length - property_array.length != 0
        prompt_message('failed')
        prompt_lint('missing_semicolon')
      elsif dry_array.length - property_array.length == 0
        prompt_message('passed')
      end
    end
end