require_relative '../lib/lint_private.rb'
require 'colorize'
class Linters < LintPrivate
  def which_default_file?(selected_file, file_list)
    file_list.each do |file|
      selected_file = file_list[selected_file.to_i - 1] if file_list.index(file).to_i == selected_file.to_i - 1
    end
    'test_files/'.concat(selected_file)
  end

  def bracket_checker(selected_file)
    file = file_read(selected_file)
    open_one = []
    close_one = []
    counter = 1
    line_no = 0
    i = 0
    file.each_line do |line|
      i += 1
      if line.include?('{')
        open_one << i
      elsif line.include?('}')
        close_one << i
      end
    end
    bracket_condition_check(open_one, close_one, file, counter, line_no)
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
