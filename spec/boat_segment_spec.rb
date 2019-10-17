require_relative '../lib/boat_segment.rb'

describe BoatSegment do

  let(:boat_segment) { BoatSegment.new }

  describe "#boat" do
  
    it "defaults to nil" do
      expect(boat_segment.boat).to eq(nil)
    end

  end

  describe "#set_boat" do

    it "sets #boat to the argument passed in" do
      boat_double = double("Boat Object")

      boat_segment.set_boat(boat_double)

      expect(boat_segment.boat).to eq(boat_double)
    end

    it "returns self" do  
      boat_double = double("Boat Object")

      result = boat_segment.set_boat(boat_double)

      expect(result).to eq(boat_segment)
    end
  end

  describe "#coordinate" do
  
    it "defaults to nil" do
      expect(boat_segment.coordinate).to eq(nil)
    end

  end

  describe "#set_coordinate" do

    it "sets #coordinate to the argument passed in" do
      coordinate_double = double("Coordinate Object")

      boat_segment.set_coordinate(coordinate_double)

      expect(boat_segment.coordinate).to eq(coordinate_double)
    end

    it "returns self" do  
      coordinate_double = double("Coordinate Object")

      result = boat_segment.set_coordinate(coordinate_double)

      expect(result).to eq(boat_segment)
    end
  end

  describe "#hit?" do
  
    it "defaults to false" do
      expect(boat_segment.hit?).to eq(false)
    end

  end
  
  describe "#mark_as_hit" do

    it "changes #hit? to return true" do
      boat_segment.mark_as_hit
      expect(boat_segment.hit?).to eq(true)
    end

    it "returns self" do  
      result = boat_segment.mark_as_hit

      expect(result).to eq(boat_segment)
    end
  end

end
