module FileReader
  
  def file_read
    @file_read = File.read("lint-style.css")
    @file_read
  end

  def take_file_data
    @file_data = file_read
  end

  def bracket_splitter
    @first_tag = @file_data.split('').values_at(0) 
    @last_tag = @file_data.split('').values_at(-1)
  end

  def bracket_match_keeper
    @matchs = @file_data.scan(@open_bracket).size + @file_data.scan(@closing_bracket).size
  end
end