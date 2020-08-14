require_relative '../lib/file_reader.rb'
require_relative '../lib/linters.rb'

  # describe FileReader  do
  #   subject(:file_read) { FileReader.new }
  #   context "if CSS file is read" do
  #     it "should return 'true'" do
  #       expect(file_read.file_read.class).to be(String)
  #     end
  #   end
  # end
 
  describe Linters < Prompter do
    let(:lint) { Linters.new }
    context "if both brackets are matched" do
      it "should return 'Passed' message" do
        expect(lint.count_tag).to eq(@passed)
      end
    end

    context "if both brackets are matched" do
      it "should return 'Failed' message" do
        expect(lint.count_tag).to eq(@failed)
      end
    end
  end

    
    

    
  
