require_relative '../lib/ship.rb'
require_relative '../lib/ship_segment.rb'
require_relative '../lib/coordinate.rb'

describe Ship do

  let(:ship) { Ship.new }

  describe "#type" do

    it "defaults to 'Ship'" do
      expect(ship.type).to eq("Ship")
    end

  end

  describe "#set_type" do

    it "it sets the return value of #type with the argument passed in" do
      ship_type_arg = "Destroyer"

      ship.set_type(ship_type_arg)

      expect(ship.type).to eq(ship_type_arg)  
    end

    it "returns self" do
      ship_type_arg = "Destroyer"

      result = ship.set_type(ship_type_arg)

      expect(result).to eq(ship)  
    end

  end

  describe "#segments" do 

    it "defaults to an empty array" do
      expect(ship.segments).to eq([ ])
    end

  end

  describe "#set_segments" do

    it "it sets the return value of #segments with the argument passed in" do
      segments_arg = [double("Segment 1"), double("Segment 2")]

      ship.set_segments(segments_arg)

      expect(ship.segments).to eq(segments_arg)  
    end

    it "returns self" do
      segments_arg = [double("Segment 1"), double("Segment 2")]

      result = ship.set_segments(segments_arg)

      expect(result).to eq(ship)  
    end

  end

  describe "#sunk?" do

    it "returns true when all segments return true for #hit?" do
      segment1 = instance_double("shipSegment", :hit? => true)
      segment2 = instance_double("shipSegment", :hit? => true)
      ship.set_segments([segment1, segment2])

      result = ship.sunk?

      expect(result).to eq(true)
    end

    it "returns false when one segment returns false for #hit?" do
      segment1 = instance_double("shipSegment", :hit? => false)
      segment2 = instance_double("shipSegment", :hit? => true)
      ship.set_segments([segment1, segment2])

      result = ship.sunk?

      expect(result).to eq(false)

    end
  end

  describe "#has_coordinate" do

    it "returns true when any segments has the coordinate passed in as an argument" do
      segment1_coordinate = Coordinate.new("a", "1")
      segment1 = instance_double("shipSegment", :hit? => false, :coordinate => segment1_coordinate)
      segment2 = instance_double("shipSegment", :hit? => false)
      ship.set_segments([segment1, segment2])

      result = ship.has_coordinate?(Coordinate.new("a", "1"))

      expect(result).to be(true)
    end

    it "returns false when none of the segments has the coordinate passed in as an argument" do
      segment1_coordinate = Coordinate.new("a", "1")
      segment2_coordinate = Coordinate.new("a", "2")
      segment1 = instance_double("shipSegment", :hit? => false, :coordinate => segment1_coordinate)
      segment2 = instance_double("shipSegment", :hit? => false, :coordinate => segment2_coordinate)
      ship.set_segments([segment1, segment2])

      result = ship.has_coordinate?(Coordinate.new("a", "3"))

      expect(result).to be(false)
    end
  end

  describe "#length" do

    it "returns the number of segments a ship has" do
      segment1 = instance_double("shipSegment")
      segment2 = instance_double("shipSegment")
      ship.set_segments([segment1, segment2])

      result = ship.length

      expect(result).to eq(2)
    end
  end

end
