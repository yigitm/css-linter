#!/usr/bin/env ruby
require_relative '../lib/linters.rb'
require 'colorize'
lint = Linters.new
print '+-+-+-+-+'.red
print '+-+'.green
print "+-+-+-+-+-+-+\n".yellow
print '|R|U|B|Y|'.red
print '|-|'.green
print "|L|I|N|T|E|R|\n".yellow
print '+-+-+-+-+'.red
print '+-+'.green
print "+-+-+-+-+-+-+\n\n\n".yellow

file_list = ['no-bracket.css', 'missing-bracket.css', 'empty-rule.css', 'dry.css',
             'important.css', 'property.css']

puts 'Please type the name of your test file (your-file.css)'
print "or select any 'file_id' between '1 to 6' for linter check\n\n".cyan
file_list.each_with_index { |file, id| puts "#{id + 1}-#{file}\n".cyan }
selected_file = gets.chomp

unless selected_file.match?(/^[1-6]$|[.]css$/)
  loop do
    puts "Invalid entry. Please type the full file name including '.css' extension or select a number between 1..6"
    selected_file = gets.chomp
    break if selected_file.match?(/^[1-6]$|[.]css$/)
  end
end

if selected_file.match?(/^[1-6]$/)
  selected_file = lint.which_default_file?(selected_file, file_list)
  puts "processing default test file: #{selected_file}\n\n"
elsif selected_file.match(/[.]css$/)
  selected_file = 'test_files/'.concat(selected_file)
  puts "processing your test file: #{selected_file}\n\n"
end

if lint.bracket_checker(selected_file) == true
  puts "Bracket Check Status: Passed\n".green
elsif lint.bracket_checker(selected_file) == false
  puts 'Bracket Check Status: Failed'.red
  puts "No opening & closing curly brackets\n".red
elsif lint.bracket_checker(selected_file)
  puts 'Bracket Check Status: Failed'.red
  puts 'Missing Curly Bracket(s)'.red
  puts "Please check line(s): #{lint.bracket_checker(selected_file)}\n".red
end

if lint.empty_rule_checker(selected_file).length.zero?
  puts "Empty Rule Check Status: Passed\n".green
else
  puts 'Empty Rule Check Status: Failed'.red
  puts "Please check line(s): #{lint.empty_rule_checker(selected_file)}\n".red
end

if !lint.property_name_checker(selected_file).length.zero?
  puts 'Property Name Check Status: Failed'.red
  puts "Please check line(s): #{lint.property_name_checker(selected_file)}\n".red
elsif lint.property_name_checker(selected_file).length.zero?
  puts "Property Name Check Status: Passed\n".green
end

if lint.dry_violation_checker(selected_file).length.zero?
  puts "DRY Check Status: Passed\n".green
else
  puts 'Check Status: Warning - DRY violation'.yellow
  puts "Check for line(s): #{lint.dry_violation_checker(selected_file)}\n".yellow
end

if lint.important_tag_checker(selected_file).length <= 9
  puts "!important Tag Check Status: Passed\n".green
elsif lint.important_tag_checker(selected_file).length >= 10
  puts 'Check Status: Warning - !important tag recommended limit : 9'.yellow
  puts "Over usage of '!important' tag - Please check lines: #{lint.important_tag_checker(selected_file)}\n".yellow
end

puts "\nThank you for your time & support\n".cyan
print '|R|U|B|Y| '.red
print '|L|I|N|T|E|R| '.yellow
abort 'ending...'
