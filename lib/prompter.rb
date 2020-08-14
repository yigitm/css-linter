require_relative '../lib/linters.rb'
class Prompter
    attr_reader :passed,:failed,
    :missing_brackets,:no_brackets,:empty_rule
    def initialize
        @passed = 'passed'
        @failed = 'failed'
        @missing_brackets = 'missing_brackets'
        @no_brackets = 'no_brackets'
        @empty_rule = 'empty_rule'
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

    def prompt_lint(related_lint)
        case related_lint
        when 'missing_brackets'
          @missing_tag = puts "Missing curly bracket(s)"
        when 'no_brackets'
          @no_brackets = puts "No opening & closing curly brackets."
        when 'empty_rule'
          @empty_rule = puts "Emty Rule"
        else 
          "No message to display!"     
        end
    end

end