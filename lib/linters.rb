require_relative '../lib/file_reader.rb'

class Linters < FileReader
attr_reader :file_data,:open_bracket,:closing_bracket
  def initialize
    @file_data = file_data
    @open_bracket = open_bracket
    @closing_bracket = closing_bracket
  end

  def count_tag
    @file_data = @file_read
    @open_bracket = (/{/)
    @closing_bracket = (/}/)
    if @file_data.match(/{/) != nil && @file_data.match(/}/) != nil
        puts "Tag Check Status: Passed"
    else
        puts "Tag Check Status: Failed"
    end
  end
end