require_relative '../lib/lintcss.rb'
require_relative '../lib/linters.rb'

describe Lintcss do
  let(:lint) { Linters.new }
  context 'Checks user input & macth it with related string file name' do
    it "Should return a 'String' value" do
      expect(lint.file_select.class).to be(String)
    end
  end

  context 'Takes user input & read the file content' do
    it "Should return related file content as a 'String' value" do
      expect(lint.file_read.class).to be(String)
    end
  end
end
