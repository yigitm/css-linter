require_relative '../lib/linters.rb'
require_relative '../lib/lint_private.rb'

describe Linters < LintPrivate do
  let(:lint) { Linters.new }
  let(:selected_file) { '' }
  describe '#which_default_file?' do
    context 'checks the file list and match with the user selection' do
      it "should return the concat version of the file by adding 'test_files/' to string value" do
        file_list = ['no-bracket.css', 'missing-bracket.css']
        selected_file = 'no-bracket.css'
        expect(lint.which_default_file?(selected_file, file_list)).to eq('test_files/'.concat(selected_file))
      end
    end
  end

  describe '#bracket_checker' do
    context 'Checks total brakect number if sum is not zero & both bracket numbers are equal' do
      it 'Should return TRUE' do
        selected_file = 'test_files/user_file.css'
        expect(lint.bracket_checker(selected_file)).to eq(true)
      end
    end

    context 'Checks brakect number if sum is zero' do
      it 'Should return FALSE' do
        selected_file = 'test_files/no-bracket.css'
        expect(lint.bracket_checker(selected_file)).to_not be(true)
      end
    end

    context 'Checks brakect number if any opening or closing one is missing' do
      it 'Should return an array which contains the missing bracket(s) line number' do
        selected_file = 'test_files/missing-bracket.css'
        expect(lint.bracket_checker(selected_file)).to eq([1, 6, 10, 13, 15, 17])
      end
    end

    context 'Checks brakect number if any opening or closing one is missing' do
      it 'Should return an array which contains the missing bracket(s) line number' do
        selected_file = 'test_files/missing-bracket.css'
        expect(lint.bracket_checker(selected_file)).to_not eq([10])
      end
    end
  end

  describe '#empty_rule_checker' do
    context 'Checks content between opening & closing brackets and if content is empty' do
      selected_file = 'test_files/empty-rule.css'
      it 'It should returns an array which includes empty_rules line number(s)' do
        expect(lint.empty_rule_checker(selected_file)).to eq([2])
      end
    end

    context 'Checks content between opening & closing brackets and if content is empty' do
      selected_file = 'test_files/empty-rule.css'
      it 'It should returns an array which includes empty_rules line number(s)' do
        expect(lint.empty_rule_checker(selected_file)).to_not eq([])
      end
    end
  end

  describe '#property_name_checker' do
    context 'Checks property name for missing colon & semicolons' do
      selected_file = 'test_files/property.css'
      it 'It should return an array that contains error line number(s)' do
        expect(lint.property_name_checker(selected_file)).to eq([2, 6])
      end
    end

    context 'Checks property name for missing colon & semicolons' do
      selected_file = 'test_files/property.css'
      it 'It should return an array that contains error line number(s)' do
        expect(lint.property_name_checker(selected_file)).to_not eq([0])
      end
    end
  end

  describe '#important_tag_checker(selected_file)' do
    context 'Checks lines that includes !important tag' do
      selected_file = 'test_files/important.css'
      it 'It should return an array that contains tag line number(s)' do
        expect(lint.important_tag_checker(selected_file)).to eq([2, 6, 11, 15, 19, 24, 28, 33, 39, 43])
      end
    end
  end

  describe '#dry_violation_checker' do
    context 'Checks property names if any DRY violation is find' do
      selected_file = 'test_files/dry.css'
      it 'It should return an array that contains error line number(s)' do
        expect(lint.dry_violation_checker(selected_file)).to eq([2, 7])
      end
    end

    context 'Checks property names if any DRY violation is find' do
      selected_file = 'test_files/dry.css'
      it 'It should return an array that contains error line number(s)' do
        expect(lint.dry_violation_checker(selected_file)).to_not eq([7])
      end
    end
  end
end
