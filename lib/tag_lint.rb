require_relative '../lib/file_reader.rb'

class TagLint < FileReader
attr_reader :tag,:file_data
  def initialize
    @tag = tag
    @file_data = file_read
  end

  def count_tag
    p @file_data.split()
  end
end