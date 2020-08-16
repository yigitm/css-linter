require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
  attr_reader :passed, :failed, :warning,
              :missing_brackets, :no_brackets, :empty_rule, :important_tag, :dry_violation, :file_list

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
      puts "\n\nPlease select any 'file_id' between '1 to 9' for linter check\n".white
      prompt_file_list
      @selected_file = gets.chomp
      if @selected_file.match(/[1-6]/).nil?
        puts 'Invalid entry. Please type/select a number between 1..9'
      elsif !@selected_file.match(/[1-6]/).nil?
        @valid = true
        @selected_file
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

  def prompt_stop_execute
    puts "\nThank you for your time & support\n".white
    print '|R|U|B|Y| '.red
    print '|L|I|N|T|E|R| '.yellow
    abort 'ending...'
  end
end
