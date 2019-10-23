require_relative '../lib/coordinate.rb'

describe Coordinate do

  describe "#new" do

    it "returns a Struct with a #row and #column" do
      coordinate = Coordinate.new("a", "1")
      expect(coordinate).to be_a(Struct)
      expect(coordinate.row).to eq("a")
      expect(coordinate.column).to eq("1")
    end

  end
end
