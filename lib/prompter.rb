require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
  attr_reader :messages

  def initialize
    @messages = messages
  end

  def prompt_message(index_one, index_two = nil, index_three = nil)
    @messages = ['Check Status: Passed', 'Chec k Status: Failed', 'Check Status: Warning', 'Missing curly bracket(s)', 
    'No opening & closing curly brackets.', 'Empty Rule', 'Syntax error: Property Name', "Over usage of '!important' - Recommended Limit: 9",
    'DRY violation', "Over usage of '!important' tag - ", ]
    return @messages[index_one.to_i], @messages[index_two.to_i], @messages[index_three.to_i]
  end
  
  def tag_lines
    @conditions.each {|index| index }
  end
  
  

end

