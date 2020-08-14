module FileReader
  
  def file_read
    @file_read = File.read("lint-style.css")
    @file_read
  end
end