require_relative '../lib/linters.rb'
class Prompter
    attr_reader :message,:passed,:failed,
    :missing_brackets,:no_brackets
    def initialize
        @message = message
        @passed = 'passed'
        @failed = 'failed'
        @missing_brackets = 'missing_brackets'
        @no_brackets = 'no_brackets'
    end

    def prompt_message(message)
        case message 
        when 'passed'
            @passed = puts "Tag Check Status: Passed"
        when 'failed'
            @failed = puts "Tag Check Status: Failed"
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
        else 
            "No message to display!"     
        end
    end



end