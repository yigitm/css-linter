require_relative '../lib/prompter.rb'
require 'colorize'
class Linters < Prompter
  def which_default_file?(selected_file, file_list)
    file_list.each do |file|
      selected_file = file_list[selected_file.to_i - 1] if file_list.index(file).to_i == selected_file.to_i - 1
    end
    'test_files/'.concat(selected_file)
  end

  def file_read(file)
    File.read(file)
  rescue StandardError
    abort 'Please enter a correct file name & re-launch the programme'
  end

  def bracket_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    counter = 1
    index = 0
    missing_brackets = []
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
        missing_brackets << index
      elsif counter == 2 && line.match?(/\S/)
        conditions << 0
      elsif counter == 2
        conditions << 'c2'
        counter = 4
        missing_brackets << index
      elsif counter.zero?
        conditions << 0
        counter = 2
      elsif counter == 4
        conditions << 'no-match'
        counter = 1
      end
    end

    if conditions.none?('c1') && conditions.none?('c2')
      true
    elsif conditions.none?('{') && conditions.none?('}')
      false
    elsif !missing_brackets.length.zero?
      missing_brackets
    end
  end

  def empty_rule_checker(selected_file)
    f = file_read(selected_file)
    counter = 1
    index = 0
    empty_rules = []
    f.each_line do |line|
      index += 1
      counter = 2 if line.include?('.') && counter == 1
      counter = 1 if line.include?(';') && counter == 2
      if line.include?('}') && counter != 1
        empty_rules << index
        counter = 1
      end
    end
    empty_rules
  end

  def property_name_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    index = 0
    f.each_line do |line|
      index += 1
      if line.match?(/^+\s*\w/)
        conditions << index if !line.match?(/:/) || !line.match?(/;/)
      end
    end
    conditions
  end

  def important_tag_checker(selected_file)
    f = file_read(selected_file)
    conditions = []
    index = 0
    f.each_line do |line|
      index += 1
      conditions << index if line.match?('!important')
    end

    conditions unless conditions.length <= 9
  end

  def dry_violation_checker(selected_file)
    f = file_read(selected_file)
    dry_count = []
    conditions = []
    index = 0
    f.each_line do |line|
      conditions << line if line.match?(/\S*\w*\s\W*\w*;/)
    end

    f.each_line do |line|
      index += 1
      dry_count << index if conditions.include?(line) && conditions.count(line) >= 2
    end
    dry_count
  end
end
