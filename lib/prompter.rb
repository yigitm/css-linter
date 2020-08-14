require_relative '../lib/linters.rb'
class Prompter
    attr_reader :message,:passed,:failed
    def initialize
        @message = message
        @passed = passed
        @failed = failed
    end

    def prompt_message(message)
        case message 
        when 'passed'
             puts @passed = "Tag Check Status: Passed" 
        when 'failed'
             puts @failed = "Tag Check Status: Failed"
        else 
            "No message to display!"     
        end
    end
end