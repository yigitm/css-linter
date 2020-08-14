require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:closing_bracket,
:first_tag,:last_tag,:matchs
  def initialize
    @file_data = file_data
    @open_bracket = (/{/)
    @closing_bracket = (/}/)
    @first_tag = first_tag
    @last_tag = last_tag
    @matchs = matchs
  end

    def tag_checker
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
      elsif first_tag == ['{'] && last_tag == ['}'] && matchs.odd?
        prompt_message('failed')
        prompt_lint('missing_brackets')
      end
    end

    def empty_rule_checker
      
      
    end








end