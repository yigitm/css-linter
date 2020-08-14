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
  
  def count_tag
    @file_data = file_read
    @open_bracket = (/{/)
    @closing_bracket = (/}/)
    if @open_bracket.match(@file_data).to_s == @open_bracket && @closing_bracket.match(@file_data).to_s == @closing_bracket
       prompt_message('passed')
    else
       prompt_message('failed')
    end
  end
end