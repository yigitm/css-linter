require_relative '../lib/prompter.rb'
require 'colorize'
class Linters < Prompter
  
  def which_default_file?(selected_file, file_list)
     file_list.each do |file| 
        if file_list.index(file).to_i == selected_file.to_i - 1
          selected_file = file_list[selected_file.to_i - 1]
        end
    end
    return 'test_files/'.concat(selected_file) 
  end

  def file_read(file)
    begin
      file_data = File.read(file)
    rescue => exception
      abort'Please enter a correct file name & re-launch the programme'
    end
  end
  
  def bracket_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    counter = 1
    index = 0
    f.each_line do |line|
      index += 1
      if line.include?('{')
        conditions << '{'
        counter = 0
      elsif line.include?('}')
        conditions << '}'
        counter = 4
      elsif counter == 1
        conditions << 'c1'
        counter = 0
        prompt_message('failed')
        prompt_lint_error('missing_brackets')
        puts "check line: #{index}".red
      elsif counter == 2 && line.match?(/\S/)
        conditions << 0
      elsif counter == 2
        conditions << 'c2'
        counter = 4
        prompt_message('failed')
        prompt_lint_error('missing_brackets')
        puts "check line: #{index}".red
      elsif counter == 0
        conditions << 0
        counter = 2
      elsif counter == 4
        conditions << 'no-match'
        counter = 1 
      end
    end
    if conditions.none?('c1') && conditions.none?('c2')
      print 'Bracket Check / '.green
      prompt_message('passed')
    elsif conditions.none?('{') && conditions.none?('}')
      puts 
      prompt_message('failed')
      prompt_lint_error('no_brackets')
    end
  end

  def empty_rule_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    counter = 1
    index = 0
    empty_rules = []
    f.each_line do |line|
      index += 1
      if line.include?('.') && counter == 1
        conditions << 'passed-one'
        counter = 2
      elsif line.include?('.') && counter != 1
        conditions << 'passed-one'
      elsif line.include?(';') && counter == 2
        conditions << 'passed-two'
        counter = 1
      elsif line.include?(';') && counter != 2
        conditions << 'passed-two'
      elsif line.include?('}') && counter == 1
        conditions << 'passed-three'
      elsif line.include?('}') && counter != 1
        empty_rules << index
        conditions << 'passed-three'
        counter = 1
      else
        conditions << 'no-match'
      end
    end
      empty_rules.each {|item| item }
  end
 
  def property_name_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    index = 0
    f.each_line do |line|
      index += 1
       if line.match?(/^+\s*\w/)
         if !(line.match?(/:/)) || !(line.match?(/;/))
           conditions << index
         end
       end
    end
    conditions
  end

  def important_tag_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    counter = 0
    index = 0
    f.each_line do |line|
      index += 1
      if line.match?('!important')
        conditions << index 
      end
    end

    if conditions.length >= 10
      conditions.each { |item| item }
    end
  end

  def dry_violation_checker(selected_file)
    f = file_read(selected_file)
    dry_count = []
    conditions = []
    index = 0
    counter = []
    f.each_line do |line|
      if line.match?(/\S*\w*\s\W*\w*;/)
        conditions << line
      end
    end

    f.each_line do |line|
      index += 1
      if conditions.include?(line) && conditions.count(line) >=2
        dry_count << index
      end
    end
    dry_count
  end
end