require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
    attr_reader :passed,:failed,:warning,
    :missing_brackets,:no_brackets,:empty_rule,:important_tag,:dry_violation,:file_list
    # :file_list,:file_bn,:file_bm,:file_e,:file_i,:file_d,:file_p,:selected_file,:valid
    
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
        # @file_bn = 'lint-bracket_no.css'
        # @file_bm = 'lint-bracket_missing.css'
        # @file_e = 'lint-empty-rule.css'
        # @file_i = 'lint-important.css'
        # @file_d = 'lint-dry.css'
        # @file_p = 'lint-property.css'
        @selected_file = selected_file
        @valid = false
    end

    def prompt_ascii
      print "+-+-+-+-+".red 
      print "+-+".green 
      print "+-+-+-+-+-+-+\n".yellow
      print"|R|U|B|Y|".red
      print "|-|".green 
      print "|L|I|N|T|E|R|\n".yellow
      print "+-+-+-+-+".red 
      print "+-+".green
      print "+-+-+-+-+-+-+\n".yellow
    end

    def prompt_welcome
      loop do
        prompt_ascii
        puts "\n\nPlease select any 'file_id' between '1 to 9' for linter check\n".white
        prompt_file_list
        @selected_file = gets.chomp
        if @selected_file.match(/[1-5]/) == nil
        puts "Invalid entry. Please type/select a number between 1..9"
        elsif @selected_file.match(/[1-5]/) != nil
          @valid = true
          @selected_file
        end
        @selected_file
        break if @valid == true
      end
    end

    def prompt_file_list
      @file_list = ['lint-bracket_no.css','lint-bracket_missing.css','lint-empty-rule.css',
        'lint-important.css','lint-dry.css','lint-property.css']
      @file_list.each_with_index do |file, id|
        puts "#{id+1}-#{file}\n".light_blue
      end
    end

    def prompt_message(message)
        case message 
        when 'passed'
            @passed = puts "Check Status: Passed".green
        when 'failed'
            @failed = puts "Check Status: Failed".red
        when 'warning'
            @warning = puts "Check Status: Warning".yellow
        else 
            "No message to display!"     
        end
    end

    def prompt_lint(lint_message)
        case lint_message
        when 'missing_brackets'
          @missing_tag = puts "Missing curly bracket(s)".red
        when 'no_brackets'
          @no_brackets = puts "No opening & closing curly brackets.".red
        when 'empty_rule'
          @empty_rule = puts "Empty Rule".red
        when '!important'
          @important_tag = puts "Over usage of '!important' - Recommended Limit: 9".yellow
        when 'dry_violation'
          @dry_violation = puts "DRY violation".yellow
        when 'property_name'
          @property_name = puts "Syntax error: Property Name".red
        else
          "No message to display!"   
        end
    end    
end