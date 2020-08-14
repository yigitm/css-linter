require_relative '../lib/file_reader.rb'
require_relative '../lib/linters.rb'

  describe FileReader  do
    subject(:file_read) { FileReader.new }
    context "if CSS file is read" do
      it "should return 'true'" do
        expect(file_read.file_read).to eq(true)
      end
    end
  end
  
  describe Linters do
    let(:lint) { Linters.new }
    context "if both brackets are matched" do
      it "should should return 'Passed' message" do
        lint.file_read
        expect(lint.count_tag).to eq('Tag Check Status: Passed')
      end
    end
  end

    
    

    
  
