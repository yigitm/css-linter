require_relative '../lib/linters.rb'
require 'colorize'
class LintPrivate
  private

  def file_read(file)
    File.read(file)
  rescue StandardError
    abort 'Please enter a correct file name & re-launch the programme'
  end

  def bracket_condition_check(selected_file, open_one, close_one, counter, line_no)
    if open_one.length == close_one.length && !(open_one + close_one).length.zero?
      true
    elsif (open_one + close_one).length.zero?
      false
    elsif open_one.length != close_one.length
      missing_bracket_checker(selected_file, counter, line_no)
    end
  end

  def missing_bracket_checker(selected_file, counter, line_no)
    missing_brackets = []
    file_read(selected_file).each_line do |line|
      line_no += 1
      if counter == 1 && line.include?('{') || counter == 2 && !line.match?(/(\S|})/)
        case counter
        when 1
          counter = 0
          missing_brackets << line_no
        when 2
          counter = 4
          missing_brackets << line_no
        else            
          if counter.zero?
            counter = 2
          elsif counter == 4
            counter = 1
          end
        end
      end
      missing_brackets
    end
    
  end
end
