require_relative '../lib/lintcss.rb'
require_relative '../lib/linters.rb'

describe Linters < Prompter do
  let(:lint) { Linters.new }
  describe '#bracket_checker' do
    context 'Checks total brakects number if matchs sum is even & not zero' do
      it "Should return 'passed' message" do
        expect(lint.bracket_checker).to eq(@passed)
      end
    end

    context 'Checks total brakects number if matchs sum is odd & not zero' do
      it "Should return 'failed' & 'missing_brackets' message" do
        expect(lint.bracket_checker).to eq(@failed)
        expect(lint.bracket_checker).to eq(@missing_brackets)
      end
    end

    context 'Checks total brakects number if no matches found' do
      it "Should return 'failed' & 'no_brackets' message" do
        expect(lint.bracket_checker).to eq(@failed)
        expect(lint.bracket_checker).to eq(@no_brackets)
      end
    end

    context 'Checks the first & last regexes and matched pairs/(even numbers)' do
      context 'If first & last regex conditions are true but matchs sum is odd/(not pairs)' do
        it "Should return 'failed' & 'missing_brackets' message" do
          expect(lint.bracket_checker).to eq(@failed)
          expect(lint.bracket_checker).to eq(@missing_brackets)
        end
      end
    end
  end

  describe '#empty_rule_checker' do
    context 'Checks content between openning & closing brackets and if content is empty' do
      it "It should returns 'failed' & 'empty_rule' message" do
        expect(lint.empty_rule_checker).to eq(@failed)
        expect(lint.empty_rule_checker).to eq(@empty_rule)
      end
    end

    context 'Checks content between openning & closing brackets and if content is NOT empty' do
      it "It should returns 'passed' message" do
        expect(lint.empty_rule_checker).to eq(@passed)
      end
    end
  end

  describe '#important_tag_checker' do
    context 'Checks the count of !important tag & if count is MORE than 10' do
      it "It should returns a warning message 'Over usage of '!important' - Recommended Limit: 9'" do
        expect(lint.important_tag_checker).to eq(@failed)
        expect(lint.important_tag_checker).to eq(@important_tag)
      end
    end

    context 'Checks the count of !important tag & if count is LESS than 10' do
      it "It should returns 'passed' message" do
        expect(lint.important_tag_checker).to eq(@passed)
      end
    end
  end

  describe '#dry_violation_checker' do
    context 'Checks the all property names If any duplicates are find' do
      it "It should returns 'failed' & 'DRY violation' message" do
        expect(lint.dry_violation_checker).to eq(@warning)
        expect(lint.dry_violation_checker).to eq(@dry_violation)
      end
    end

    context 'If NO duplicates are find' do
      it "It should returns 'passed' message" do
        expect(lint.dry_violation_checker).to eq(@passed)
      end
    end
  end

  describe '#property_name_checker' do
    context 'Checks the all colon(s) & semi-colon(s) in property names and if any missing' do
      it "It should returns 'failed' & 'Syntax error: Property Name' message" do
        expect(lint.property_name_checker).to eq(@failed)
        expect(lint.property_name_checker).to eq(@missing_semicolon)
      end
    end

    context 'If colon(s) & semi-colon(s) syntax is correct' do
      it "It should returns 'passed' message" do
        expect(lint.property_name_checker).to eq(@passed)
      end
    end
  end
end
