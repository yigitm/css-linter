require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:closing_bracket,
:first_tag,:last_tag
  def initialize
    @file_data = file_data
    @open_bracket = open_bracket
    @closing_bracket = closing_bracket
    @first_tag = first_tag
    @last_tag = last_tag
  end
    # @duplicate_open = (/{{/)
    # @duplicate_close = (/}}/)
   
    def tag_checker
      @file_data = file_read
      @open_bracket = (/{/)
      @closing_bracket = (/}/)
      @first_tag = @file_data.split('').values_at(0) 
      @last_tag = @file_data.split('').values_at(-1) 
      matchs = @file_data.scan(@open_bracket).size + @file_data.scan(@closing_bracket).size
      
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

    





end