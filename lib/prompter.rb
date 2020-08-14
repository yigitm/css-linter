require_relative '../lib/linters.rb'
class Prompter
    attr_reader :message,:passed,:failed,
    :missing_tag,:no_brackets
    def initialize
        @message = message
        @passed = 'passed'
        @failed = 'failed'
        @missing_tag = 'missing_tag'
        @no_brackets = 'no_brackets'
    end

    def prompt_message(message)
        case message 
        when 'passed'
            puts "Tag Check Status: Passed"
        when 'failed'
            puts "Tag Check Status: Failed"
        else 
            "No message to display!"     
        end
    end

    def prompt_lint(related_lint)
        case related_lint
        when 'missing_tag'
            puts @missing_tag = "Missing bracket(s)"
        when 'no_brackets'
            puts @no_brackets = "Missing opening & closing brackets."
        else 
            "No message to display!"     
        end
    end



end