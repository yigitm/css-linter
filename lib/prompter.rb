require_relative '../lib/linters.rb'
class Prompter
    attr_reader :passed,:failed,
    :missing_brackets,:no_brackets,:empty_rule,:important_tag
    def initialize
        @passed = 'passed'
        @failed = 'failed'
        @missing_brackets = 'missing_brackets'
        @no_brackets = 'no_brackets'
        @empty_rule = 'empty_rule'
        @important_tag = important_tag
    end

    def prompt_message(message)
        case message 
        when 'passed'
            @passed = puts "Check Status: Passed"
        when 'failed'
            @failed = puts "Check Status: Failed"
        else 
            "No message to display!"     
        end
    end

    def prompt_lint(lint_message)
        case lint_message
        when 'missing_brackets'
          @missing_tag = puts "Missing curly bracket(s)"
        when 'no_brackets'
          @no_brackets = puts "No opening & closing curly brackets."
        when 'empty_rule'
          @empty_rule = puts "Empty Rule"
        when '!important'
          @important_tag = puts "Over usage of '!important' - Recommended Limit: 9"
        else
          "No message to display!"     
        end
    end

end