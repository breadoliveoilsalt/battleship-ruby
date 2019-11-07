require_relative '../lib/board.rb'

describe Board do

  let(:board) { Board.new }

  it "contains nil by default" do
    expect(board.get(:a, 1)).to be(nil)
    expect(board.get(:b, 7)).to be(nil)
  end
  
  it "sets value at row, col" do
    expect(board.get(:a, 1)).to be(nil)

    expect(board.set(:a, 1, false)).to be(false)
    
    expect(board.get(:a, 1)).to be(false)
  end

end

