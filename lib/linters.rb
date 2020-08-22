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
    f = file_read
    @conditions = []
    counter = 1
    index = 0
    f.each_line do |line|
      index += 1
      if line.include?('{')
        @conditions << '{'
        counter = 0
      elsif line.include?('}')
        @conditions << '}'
        counter = 4
      elsif counter == 1
        @conditions << 'c1'
        counter = 0
        prompt_message('failed')
        prompt_lint_error('missing_brackets')
        puts "check line: #{index}".red
      elsif counter == 2 && line.match?(/\S/)
        @conditions << 0
      elsif counter == 2
        @conditions << 'c2'
        counter = 4
        prompt_message('failed')
        prompt_lint_error('missing_brackets')
        puts "check line: #{index}".red
      elsif counter == 0
        @conditions << 0
        counter = 2
      elsif counter == 4
        @conditions << 'no-match'
        counter = 1 
      end
    end
    if @conditions.none?('c1') && @conditions.none?('c2')
      print 'Bracket Check / '.green
      prompt_message('passed')
    elsif @conditions.none?('{') && @conditions.none?('}')
      puts 
      prompt_message('failed')
      prompt_lint_error('no_brackets')
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
        puts "check line: #{index}".red
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
    # file_read
    # dry_array = regex_scanner(/\S*\w*\s\W*\w*;/)
    # property_array = regex_scanner(/\S*\w*:/)
    # if find_length_difference(dry_array, property_array) != 0
    #   prompt_message('failed')
    #   prompt_lint_warning('property_name')
    # elsif find_length_difference(dry_array, property_array).zero? == true
    #   prompt_message('passed')
    # end
    f = file_read
    @conditions = []
    counter = 0
    index = 0
    f.each_line do |line|
      index += 1
       if line.match?(/^+\s*\w/)
         if !(line.match?(/:/))
           puts "error #{index}".red
         elsif !(line.match?(/;/))
           puts "error #{index}".red
         else 
           puts "Passed".green 
         end
       end
    end
  end
end
