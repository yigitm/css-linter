require 'colorize'
module Lintcss
  def which_default_file?
    @file_list = ['test_files/lint-bracket-no.css', 'test_files/lint-bracket-missing.css', 'test_files/lint-empty-rule.css',
                  'test_files/lint-important.css', 'test_files/lint-dry.css', 'test_files/lint-property.css']
    @file_list.each do |file| 
        if @file_list.index(file).to_i == @selected_file.to_i - 1
          @selected_file = @file_list[@selected_file.to_i - 1]
        end
    end
  end
end
