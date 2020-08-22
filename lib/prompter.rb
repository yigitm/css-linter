require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
  attr_reader :passed, :failed, :warning, :missing_brackets,
              :no_brackets, :empty_rule, :important_tag,
              :dry_violation

  def initialize
    @passed = 'passed'
    @failed = 'failed'
    @warning = 'warning'
    @missing_brackets = 'missing_brackets'
    @no_brackets = 'no_brackets'
    @empty_rule = 'empty_rule'
    @important_tag = 'important_tag'
    @dry_violation = 'dry_violation'
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
end