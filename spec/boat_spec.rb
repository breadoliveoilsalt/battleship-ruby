require_relative '../lib/boat.rb'
require_relative '../lib/boat_segment.rb'

describe Boat do

  let(:boat) { Boat.new }

  describe "#type" do

    it "defaults to nil" do
      expect(boat.type).to be(nil)
    end

  end

  describe "#set_type" do

    it "it sets the return value of #type with the argument passed in" do
      boat_type_arg = "Destroyer"

      boat.set_type(boat_type_arg)

      expect(boat.type).to eq(boat_type_arg)  
    end

    it "returns self" do
      boat_type_arg = "Destroyer"

      result = boat.set_type(boat_type_arg)

      expect(result).to eq(boat)  
    end

  end

  describe "#segments" do 

    it "defaults to an empty array" do
      expect(boat.segments).to eq([ ])
    end

  end

  describe "#set_segments" do

    it "it sets the return value of #segments with the argument passed in" do
      segments_arg = [double("Segment 1"), double("Segment 2")]

      boat.set_segments(segments_arg)

      expect(boat.segments).to eq(segments_arg)  
    end

    it "returns self" do
      segments_arg = [double("Segment 1"), double("Segment 2")]

      result = boat.set_segments(segments_arg)

      expect(result).to eq(boat)  
    end

  end

  describe "#sunk?" do

    it "returns true when all segments return true for #hit?" do
      segment1 = instance_double("BoatSegment", :hit? => true)
      segment2 = instance_double("BoatSegment", :hit? => true)
      boat.set_segments([segment1, segment2])

      result = boat.sunk?

      expect(result).to eq(true)
    end

    it "returns false when one segment returns false for #hit?" do
      segment1 = instance_double("BoatSegment", :hit? => false)
      segment2 = instance_double("BoatSegment", :hit? => true)
      boat.set_segments([segment1, segment2])

      result = boat.sunk?

      expect(result).to eq(false)

    end
  end
end
