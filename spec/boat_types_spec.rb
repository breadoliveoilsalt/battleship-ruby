require_relative '../lib/boat_types.rb'

describe BoatTypes do

  describe "#self.with_segment_counts" do 

    it "returns a two dimensional array where each sub-array contains a boat type and a segment count" do
    expected_result = [
      ["Carrier", 5],
      ["Battleship", 4],
      ["Destroyer", 3],
      ["Submarine", 3],
      ["Patrol Boat", 2]
    ]

    expect(BoatTypes.with_segment_counts).to eq(expected_result)
    end

  end

end
