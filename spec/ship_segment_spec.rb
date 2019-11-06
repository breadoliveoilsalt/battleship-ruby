require_relative '../lib/ship_segment.rb'
require_relative '../lib/ship.rb'

describe ShipSegment do

  let(:ship_segment) { ShipSegment.new }

  describe "#ship" do
  
    it "defaults to nil" do
      expect(ship_segment.ship).to eq(nil)
    end

  end

  describe "#set_ship" do

    it "sets #ship to the argument passed in" do
      ship_double = double("ship Object")

      ship_segment.set_ship(ship_double)

      expect(ship_segment.ship).to eq(ship_double)
    end

    it "returns self" do  
      ship_double = double("ship Object")

      result = ship_segment.set_ship(ship_double)

      expect(result).to eq(ship_segment)
    end
  end

  describe "#board" do
  
    it "defaults to nil" do
      expect(ship_segment.board).to eq(nil)
    end

  end

  describe "#set_board" do

    it "sets #board to the argument passed in" do
      board_double = double("Board Object")

      ship_segment.set_board(board_double)

      expect(ship_segment.board).to eq(board_double)
    end

    it "returns self" do  
      board_double = double("Board Object")

      result = ship_segment.set_board(board_double)

      expect(result).to eq(ship_segment)
    end
  end

  describe "#coordinate" do
  
    it "defaults to nil" do
      expect(ship_segment.coordinate).to eq(nil)
    end

  end

  describe "#set_coordinate" do

    it "sets #coordinate to the argument passed in" do
      coordinate_double = double("Coordinate Object")

      ship_segment.set_coordinate(coordinate_double)

      expect(ship_segment.coordinate).to eq(coordinate_double)
    end

    it "returns self" do  
      coordinate_double = double("Coordinate Object")

      result = ship_segment.set_coordinate(coordinate_double)

      expect(result).to eq(ship_segment)
    end
  end

  describe "#hit?" do
  
    it "defaults to false" do
      expect(ship_segment.hit?).to eq(false)
    end

  end
  
  describe "#mark_as_hit" do

    it "changes #hit? to return true" do
      ship_segment.mark_as_hit
      expect(ship_segment.hit?).to eq(true)
    end

    it "returns self" do  
      result = ship_segment.mark_as_hit

      expect(result).to eq(ship_segment)
    end
  end

  describe "#ship_sunk?" do

    it "returns true if its ship is sunk" do 
      ship = instance_double("Ship", "sunk?" => true)
      ship_segment.set_ship(ship)

      expect(ship_segment.ship_sunk?).to be(true)
    end

    it "returns false if its ship is not sunk" do 
      ship = instance_double("Ship", "sunk?" => false)
      ship_segment.set_ship(ship)

      expect(ship_segment.ship_sunk?).to be(false)
    end

  end

  describe "#ship_type" do

    it "returns the type of the ship to which the segment belongs" do
      ship = instance_double("Ship", "type" => "Battleship")
      ship_segment.set_ship(ship)

      expect(ship_segment.ship_type).to eq("Battleship")
    end

  end

end
