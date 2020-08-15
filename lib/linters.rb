require_relative '../lib/prompter.rb'
class Linters < Prompter
include LintCSS
attr_reader :file_data,:open_bracket,:close_bracket,
:first_bracket,:last_bracket,:matchs,:indish_open,:indish_close,:index
  def initialize
    @file_data = file_data
    @open_bracket = (/{/)
    @close_bracket = (/}/)
    @first_bracket = first_bracket
    @last_bracket = last_bracket
    @matchs = matchs
    @indish_open = indish_open
    @indish_close = indish_close
    @index = index
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
      indish_open = []
      indish_close = []
      take_file_data
      string_to_array
      @indish_open = find_bracket_index(indish_open)
      @indish_close = find_bracket_index(indish_close)
      check_fill_or_not(indish_open, indish_close)
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
end