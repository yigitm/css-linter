require_relative '../lib/file_reader.rb'
require_relative '../lib/linters.rb'
  
  # describe FileReader do
  #   let(:lint) { Linters.new }
  #   context "if CSS file is read successfully" do
  #     it "should return a 'String' value" do
  #       expect(lint.file_read.class).to be(String)
  #     end
  #   end
  # end
 
  describe Linters < Prompter do
    let(:lint) { Linters.new }
    context "if both brackets are matched" do
      it "should return 'Passed' message" do
        expect(lint.tag_checker).to be(true)
      end
    end

    # context "if both brackets are matched" do
    #   let(:file_data) { Linters.new }
    #   it "should return 'Failed' message" do
    #     expect(lint.tag_checker).to be(false)
    #   end
    # end
  end

    
    

    
  
