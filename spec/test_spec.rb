require_relative '../lib/scanner.rb'

describe Scanner do
    let(:test_scan) { Scanner.new "Lorem ipsum FileSc" }
    
    it "should read 6 character from sentence" do
        expect(test_scan.peek 6 ).to eq "FileSc"
    end

    
end
