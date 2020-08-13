class FileReader
attr_reader :file,:file_read,:file_split
  def initialize
    @file = file
    @file_read = file_read
  end
  
  def file_read
    @file_read = File.read("lint-style.css")
  end














end