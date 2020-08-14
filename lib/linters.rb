require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:closing_bracket,:result
  def initialize
    @file_data = file_data
    @open_bracket = open_bracket
    @closing_bracket = closing_bracket
    @result = result
  end
  
  def tag_checker
    @file_data = file_read
    @open_bracket = (/{/)
    @closing_bracket = (/}/)
    if @file_data.match(@open_bracket).to_s == "{" && @file_data.match(@closing_bracket).to_s == "}" 
        prompt_message('passed')
        true
    else
        prompt_message('failed')
        false
    end
  end
end