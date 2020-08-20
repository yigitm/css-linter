require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
  attr_reader :passed, :failed, :warning, :missing_brackets,
              :no_brackets, :empty_rule, :important_tag,
              :dry_violation, :file_list, :selected_file

  def initialize
    @passed = 'passed'
    @failed = 'failed'
    @warning = 'warning'
    @missing_brackets = 'missing_brackets'
    @no_brackets = 'no_brackets'
    @empty_rule = 'empty_rule'
    @important_tag = 'important_tag'
    @dry_violation = 'dry_violation'
    @file_list = file_list
    @selected_file = selected_file
    @valid = false
  end

  def prompt_ascii
    print '+-+-+-+-+'.red
    print '+-+'.green
    print "+-+-+-+-+-+-+\n".yellow
    print '|R|U|B|Y|'.red
    print '|-|'.green
    print "|L|I|N|T|E|R|\n".yellow
    print '+-+-+-+-+'.red
    print '+-+'.green
    print "+-+-+-+-+-+-+\n".yellow
  end

  def prompt_welcome
    loop do
      prompt_ascii
      puts "\n\nPlease type the name of your test file (your-file.css) or select any 'file_id' between '1 to 6' for linter check\n".white
      prompt_file_list
      @selected_file = gets.chomp
      if @selected_file.match(/^[1-6]|.css$/).nil?
        puts 'Invalid entry. Please type the full file name including ".css" extension or select a number between 1..6'
      elsif !(@selected_file.match(/[1-6]/).nil?) && @selected_file.size == 1
        @valid = true
        which_default_file?
        puts "processing default test file: #{@selected_file}"
      elsif !(@selected_file.match(/.css$/).nil?) && @selected_file.size >= 4
        @selected_file = 'test_files/'.concat(@selected_file)
        puts "processing your test file: #{@selected_file}"
        @valid = true
      end
      break if @valid == true
    end
  end

  def prompt_file_list
    @file_list = ['lint-bracket-no.css', 'lint-bracket-missing.css', 'lint-empty-rule.css',
                  'lint-important.css', 'lint-dry.css', 'lint-property.css']
    @file_list.each_with_index do |file, id|
      puts "#{id + 1}-#{file}\n".light_blue
    end
  end
  
  def prompt_message(message)
    case message
    when 'passed'
      @passed = puts 'Check Status: Passed'.green
    when 'failed'
      @failed = puts 'Check Status: Failed'.red
    when 'warning'
      @warning = puts 'Check Status: Warning'.yellow
    else
      'No message to display!'
    end
  end

  def prompt_lint_error(lint_message)
    case lint_message
    when 'missing_brackets'
      @missing_tag = puts 'Missing curly bracket(s)'.red
    when 'no_brackets'
      @no_brackets = puts 'No opening & closing curly brackets.'.red
    when 'empty_rule'
      @empty_rule = puts 'Empty Rule'.red
    when 'property_name'
      @property_name = puts 'Syntax error: Property Name'.red
    else
      'No message to display!'
    end
  end

  def prompt_lint_warning(lint_message)
    case lint_message
    when '!important'
      @important_tag = puts "Over usage of '!important' - Recommended Limit: 9".yellow
    when 'dry_violation'
      @dry_violation = puts 'DRY violation'.yellow
    else
      'No message to display!'
    end
  end

  def prompt_no_open_bracket
    file = @selected_file.to_s
    i = 1
    File.readlines(file).each do |item|
      line = "line #{i}: #{item} missing brackets"
      if item.match?(/[.]/) == true && item.match?(/[.]?\{/) == false
        puts line.red
      end
      i += 1
    end
  end
  
  def prompt_no_close_bracket
    file = @selected_file.to_s
    File.readlines(file).each_with_index do |item, index|
      line = "Possible missing closing bracket, please check line: #{index + 1}"
      if item.match?(/^\n/)
        puts line.red
      end
    end 
  end

  def prompt_stop_execute
    puts "\nThank you for your time & support\n".white
    print '|R|U|B|Y| '.red
    print '|L|I|N|T|E|R| '.yellow
    abort 'ending...'
  end
end
