require_relative '../lib/lint_CSS.rb'
require_relative '../lib/linters.rb'
  
  describe LintCSS do
    let(:lint) { Linters.new }
    context "if CSS file is read successfully" do
      it "Should return a 'String' value" do
        expect(lint.file_read.class).to be(String)
      end
    end
  end

  describe Linters < Prompter do
    describe "#bracket_checker" do
      let(:lint) { Linters.new }
      context "Checks total brakects number if matchs sum is even & not zero" do
        it "Should return 'passed' message" do
          expect(lint.bracket_checker).to eq(@passed)
        end
      end

      context "Checks total brakects number if matchs sum is odd & not zero" do
        it "Should return 'failed' & 'missing_brackets' message" do
          expect(lint.bracket_checker).to eq(@failed)
          expect(lint.bracket_checker).to eq(@missing_brackets)
        end
      end

      context "Checks total brakects number if no matches found" do
        it "Should return 'failed' & 'no_brackets' message" do
          expect(lint.bracket_checker).to eq(@failed)
          expect(lint.bracket_checker).to eq(@no_brackets)
        end
      end

      context "Checks the first & last regexes and matched pairs/(even numbers)" do
        context "If first & last regex conditions are true but matchs sum is odd/(not pairs)" do
          it "Should return 'failed' & 'missing_brackets' message" do
            expect(lint.bracket_checker).to eq(@failed)
            expect(lint.bracket_checker).to eq(@missing_brackets)
          end
        end
      end
    end

    describe "#empty_rule_checker" do
      let(:lint) { Linters.new }
      context "Checks content between openning & closing brackets and if content is empty" do
        it "It should returns 'failed' & 'emty_rule' message" do
          expect(lint.empty_rule_checker).to eq(@failed)
          expect(lint.empty_rule_checker).to eq(@empty_rule)
        end
      end
      
      context "Checks content between openning & closing brackets and if content is NOT empty" do
        it "It should returns 'passed' message" do
          expect(lint.empty_rule_checker).to eq(@passed)
        end
      end 
    end

    describe "#important_tag_checker" do
      let(:lint) { Linters.new }
      context "Checks the count of !important tag & if count is MORE than 10" do
        it "It should returns a warning message 'Over usage of '!important' - Recommended Limit: 9'" do
          expect(lint.important_tag_checker).to eq(@failed)
          expect(lint.important_tag_checker).to eq(@important_tag)
        end
      end

      context "Checks the count of !important tag & if count is LESS than 10" do
        it "It should returns 'passed' message" do
          expect(lint.important_tag_checker).to eq(@passed)
        end
      end
    end
  end

    
    

    
  
