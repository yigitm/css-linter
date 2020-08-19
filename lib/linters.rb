require_relative '../lib/prompter.rb'
class Linters < Prompter
  include Lintcss
  attr_reader :open_bracket, :close_bracket,
              :first_bracket, :last_bracket, :matchs, :indish_open, :indish_close, :dry_array,
              :stop_execution
  def initialize
    @open_bracket = /{/
    @close_bracket = /}/
    @first_bracket = first_bracket
    @last_bracket = last_bracket
    @matchs = matchs
    @indish_open = indish_open
    @indish_close = indish_close
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

  # def prompt_error_line
  #   File.open('test_files/lint-bracket-no.css') do |file|
  #     puts file.readlines().include?('{')
  #   end
  # end

  def bracket_checker
    open_bracket = regex_scanner(/{/).count
    close_bracket = regex_scanner(/}/).count
    total_brackets = open_bracket + close_bracket
    check_with_rule = regex_scanner(/^.\w/).size * 2
    if open_bracket == close_bracket && !(total_brackets.zero?) && check_with_rule == total_brackets
      prompt_message('passed')
      true
    elsif open_bracket == close_bracket && !(total_brackets.zero?) && check_with_rule != total_brackets
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
      false
    elsif close_bracket != open_bracket
      prompt_message('failed')
      prompt_lint_error('missing_brackets')
      false
    elsif total_brackets.zero?
      prompt_message('failed')
      prompt_lint_error('no_brackets')
      false
    else
      nil
    end
  end

  def empty_rule_checker
    file_read
    indish_open = find_same_brackets(open_bracket)
    indish_close = find_same_brackets(close_bracket)
    message = check_fill_or_not(indish_open, indish_close)
    if message == true
      prompt_message('failed')
      prompt_lint_error('empty_rule')
    else
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
