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
              @passed = puts "Tag Check Status: Passed"
        when 'failed'
              @failed = puts "Tag Check Status: Failed"
        else 
            "No message to display!"     
        end
    end
end