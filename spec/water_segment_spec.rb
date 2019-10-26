require_relative '../lib/water_segment.rb'

describe WaterSegment do

  let(:water_segment) { WaterSegment.new }

  describe "#board" do
  
    it "defaults to nil" do
      expect(water_segment.board).to eq(nil)
    end

  end

  describe "#set_board" do

    it "sets #board to the argument passed in" do
      board_double = double("Board Object")

      water_segment.set_board(board_double)

      expect(water_segment.board).to eq(board_double)
    end

    it "returns self" do  
      board_double = double("Board Object")

      result = water_segment.set_board(board_double)

      expect(result).to eq(water_segment)
    end
  end

  describe "#coordinate" do
  
    it "defaults to nil" do
      expect(water_segment.coordinate).to eq(nil)
    end

  end

  describe "#set_coordinate" do

    it "sets #coordinate to the argument passed in" do
      coordinate_double = double("Coordinate Object")

      water_segment.set_coordinate(coordinate_double)

      expect(water_segment.coordinate).to eq(coordinate_double)
    end

    it "returns self" do  
      coordinate_double = double("Coordinate Object")

      result = water_segment.set_coordinate(coordinate_double)

      expect(result).to eq(water_segment)
    end
  end

  describe "#hit?" do
  
    it "defaults to false" do
      expect(water_segment.hit?).to eq(false)
    end

  end
  
  describe "#mark_as_hit" do

    it "changes #hit? to return true" do
      water_segment.mark_as_hit
      expect(water_segment.hit?).to eq(true)
    end

    it "returns self" do  
      result = water_segment.mark_as_hit

      expect(result).to eq(water_segment)
    end
  end

end

