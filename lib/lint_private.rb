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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def missing_bracket_checker(selected_file, counter, line_no)
    missing_brackets = []
    file_read(selected_file).each_line do |line|
      line_no += 1
      if line.include?('{')
        counter = 0
      elsif line.include?('}')
        counter = 4
      elsif counter == 1
        counter = 0
        missing_brackets << line_no
      elsif counter == 2 && !line.match?(/\S/)
        counter = 4
        missing_brackets << line_no
      elsif counter.zero?
        counter = 2
      elsif counter == 4
        counter = 1
      end
    end
    missing_brackets
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
