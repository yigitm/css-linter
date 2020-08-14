require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:closing_bracket
  def initialize
    @file_data = file_data
    @open_bracket = open_bracket
    @closing_bracket = closing_bracket
  end
  
  def count_tag
    @file_data = file_read
    @open_bracket = (/{/)
    @closing_bracket = (/}/)
    if @file_data.match(/{/) != nil && @file_data.match(/}/) != nil
        prompt_message('passed')
    else
        prompt_message('failed')
    end
  end
end