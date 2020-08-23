require_relative '../lib/linters.rb'
require 'colorize'
class Prompter
  attr_reader :messages

  def initialize
    @messages = messages
  end

  def prompt_message(index_one, index_two = nil, index_three = nil)
    @messages = ['Check Status: Passed', 'Check Status: Failed', 'Missing curly bracket(s)', 
    'No opening & closing curly brackets.']
  end
  
  def tag_lines
    @conditions.each {|index| index }
  end

 
  
end

