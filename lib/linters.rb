require_relative '../lib/prompter.rb'
require 'colorize'
class Linters < Prompter
  include Lintcss
  attr_reader :indish_open, :indish_close, :conditions, :dry_array, :stop_execution
  def initialize
    @indish_open = indish_open
    @indish_close = indish_close
    @conditions = conditions
    @dry_array = dry_array
    @stop_execution = false
  end

  def file_read
    begin
      file_data = File.read(@selected_file.to_s)
    rescue => exception
      abort'Please enter a correct file name & re-launch the programme'
    end
  end

  def bracket_checker
    open_bracket = regex_scanner(/{/).count
    close_bracket = regex_scanner(/}/).count
    total_brackets = open_bracket + close_bracket
    check_with_rule = regex_scanner(/^.\w/).size * 2
    if open_bracket == close_bracket && !(total_brackets.zero?) && check_with_rule == total_brackets
      print 'Bracket Check / '.green
      prompt_message('passed')
      true
    elsif open_bracket == close_bracket && !(total_brackets.zero?) && !(check_with_rule == total_brackets)
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
      prompt_no_open_bracket
      prompt_no_close_bracket
      false
    elsif close_bracket != open_bracket
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
      prompt_no_open_bracket
      prompt_no_close_bracket
      false
    elsif total_brackets.zero?
      prompt_message('failed')
      prompt_lint_error('no_brackets')
      nil
    end
  end

  def empty_rule_checker
    f = file_read
    @conditions = []
    counter = 1
    index = 0
    f.each_line do |line|
      index += 1
      if line.include?('.') && counter == 1
        @conditions << 'passed-one'
        counter = 2
      elsif line.include?('.') && counter != 1
        @conditions << 'passed-one'
      elsif line.include?(';') && counter == 2
        @conditions << 'passed-two'
        counter = 1
      elsif line.include?(';') && counter != 2
        @conditions << 'passed-two'
      elsif line.include?('}') && counter == 1
        @conditions << 'passed-three'
      elsif line.include?('}') && counter != 1
        @conditions << 0
        @conditions << 'passed-three'
        counter = 1
        prompt_message('failed')
        prompt_lint_error('empty_rule')
        puts "check line: #{index}"
      else
        @conditions << 'no-match'
      end
    end
    if @conditions.none?(0)
      print 'Emty Rule Check / '.green
      prompt_message('passed')
    end
  end
 
  def important_tag_checker
    count_important = file_read.scan('!important').size
    case count_important
    when (0..9)
      prompt_message('passed')
    when (10..file_read.size)
      prompt_message('warning')
      prompt_lint_warning('!important')
    else
      false
    end
  end

  def dry_violation_checker
    dry_array = file_read.scan(/\S*\w*\s\W*\w*;/)

    if dry_array == dry_array.uniq
      prompt_message('passed')
    else
      prompt_message('warning')
      prompt_lint_warning('dry_violation')
    end
  end

  def property_name_checker
    file_read
    dry_array = regex_scanner(/\S*\w*\s\W*\w*;/)
    property_array = regex_scanner(/\S*\w*:/)
    if find_length_difference(dry_array, property_array) != 0
      prompt_message('failed')
      prompt_lint_warning('property_name')
    elsif find_length_difference(dry_array, property_array).zero? == true
      prompt_message('passed')
    end
  end
end
