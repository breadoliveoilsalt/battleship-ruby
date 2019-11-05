require_relative '../lib/ship_types.rb'

describe ShipTypes do

  describe "#self.with_segment_counts" do 

    it "returns a two dimensional array where each sub-array contains a ship type and a segment count" do
    expected_result = [
      ["Carrier", 5],
      ["Battleship", 4],
      ["Destroyer", 3],
      ["Submarine", 3],
      ["Patrol Boat", 2]
    ]

    expect(ShipTypes.with_segment_counts).to eq(expected_result)
    end

  end

end
