require_relative '../lib/file_reader.rb'
require_relative '../lib/linters.rb'
  
  describe FileReader do
    let(:lint) { Linters.new }
    context "if CSS file is read successfully" do
      it "Should return a 'String' value" do
        expect(lint.file_read.class).to be(String)
      end
    end
  end

  describe Linters < Prompter do
    let(:lint) { Linters.new }
    context "Checks total brakects number if matchs sum is even & not zero" do
      it "Should return 'passed' message" do
        expect(lint.tag_checker).to eq(@passed)
      end
    end

    context "Checks total brakects number if matchs sum is odd & not zero" do
      it "Should return 'failed' & 'missing_brackets' message" do
        expect(lint.tag_checker).to eq(@failed)
        expect(lint.tag_checker).to eq(@missing_brackets)
      end
    end

    context "Checks total brakects number if no matches found" do
      it "Should return 'failed' & 'no_brackets' message" do
        expect(lint.tag_checker).to eq(@failed)
        expect(lint.tag_checker).to eq(@no_brackets)
      end
    end

    context "Checks the first & last regexes and matched pairs/(even numbers)" do
      context "If first & last regex conditions are true but matchs sum is odd/(not pairs)" do
        it "Should return 'failed' & 'missing_brackets' message" do
        expect(lint.tag_checker).to eq(@failed)
        expect(lint.tag_checker).to eq(@missing_brackets)
        end
      end
    end

  end

    
    

    
  
