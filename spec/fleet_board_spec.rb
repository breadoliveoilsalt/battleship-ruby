require 'require_all'
require_all 'lib'

describe FleetBoard do

  let(:ships_double) { [double("ship 1"), double("ship 2")] }
  let(:fleet_board) { FleetBoard.new(ships: ships_double) }

  describe "#set_ships" do

    it "sets the return value of #ships with the argument passed in" do
      ships = [double("ship 3"), double("ship 4")]

      fleet_board.set_ships(ships)

      expect(fleet_board.ships).to eq(ships)
    end

  end

  describe "#all_ships_sunk?" do 
    
    it "returns true when all ships respond to #sunk? with true" do 
      ship1 = instance_double("ship", :sunk? => true)
      ship2 = instance_double("ship", :sunk? => true)
      fleet_board.set_ships([ship1, ship2])

      result = fleet_board.all_ships_sunk?

      expect(result).to eq(true)
    end
    
    it "returns false when one ship respond to #sunk? with false" do 
      ship1 = instance_double("ship", :sunk? => true)
      ship2 = instance_double("ship", :sunk? => false)
      fleet_board.set_ships([ship1, ship2])

      result = fleet_board.all_ships_sunk?

      expect(result).to eq(false)
    end

  end

  describe "#data" do

    it "defaults to a 10 x 10 two dimensional array with each value being nil" do 
      expected_result = 
        [
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      
      expect(fleet_board.data).to eq(expected_result)
    end

  end

  describe "#find_ship" do

    it "returns a ship if the fleet_board has a ship with the coordinate passed in" do
      coordinate = double("Coordinate")
      ship1 = instance_double("Ship", "has_coordinate?" => true)
      ship2 = instance_double("Ship", "has_coordinate?" => false)
      fleet_board = FleetBoard.new(ships: [ship1, ship2])

      result = fleet_board.find_ship(coordinate)
      
      expect(result).to eq(ship1)
    end

    it "returns nil if the fleet_board does not have a ship with the coordinate passed in" do
      coordinate = double("Coordinate")
      ship1 = instance_double("Ship", "has_coordinate?" => false)
      ship2 = instance_double("Ship", "has_coordinate?" => false)
      fleet_board = FleetBoard.new(ships: [ship1, ship2])

      result = fleet_board.find_ship(coordinate)
      
      expect(result).to eq(nil)
    end

  end

  describe "#update_with" do 

    it "marks a data coordinate as false if the coordinate_guess passed in is a miss" do
      coordinate = Coordinate.new(0, 0)
      
      fleet_board.update_with(coordinate)

      expect(fleet_board.get(0, 0)).to be(false)
    end

    it "marks a ship_segment as hit if the coordinate_guess passed in is a hit" do
      segment = instance_double("ShipSegment", "ship_sunk?" => false)
      fleet_board.set(0, 0, segment)
      coordinate = Coordinate.new(0, 0)
      
      expect(segment).to receive(:mark_as_hit)
      fleet_board.update_with(coordinate)
    end

    it "updates the list of sunk and unsunk ships if the coordinate guess sinks a ship" do
      segment = instance_double("ShipSegment", "ship_sunk?" => true, :ship_type => "Battleship")
      allow(segment).to receive(:mark_as_hit)
      fleet_board.set(0, 0, segment)
      fleet_board.instance_variable_set("@unsunk_ships", ["Battleship"])
      fleet_board.instance_variable_set("@sunk_ships", ["Submarine"])
      coordinate = Coordinate.new(0, 0)
      
      fleet_board.update_with(coordinate)

      expect(fleet_board.sunk_ships).to eq(["Submarine", "Battleship"])
    end
  end

  describe "#update_data_with_ships" do

    it "places ship segments within the data" do
      segment1 = instance_double("ShipSegment1", :coordinate => Coordinate.new(0, 0))
      segment2 = instance_double("ShipSegment2", :coordinate => Coordinate.new(9, 9))

      ship1 = instance_double("Ship1", :segments => [segment1])
      ship2 = instance_double("Ship2", :segments => [segment2])

      fleet_board = FleetBoard.new(ships: [ship1, ship2])

      fleet_board.update_data_with_ships 

      expect(fleet_board.data[0][0]).to eq(segment1)
      expect(fleet_board.data[9][9]).to eq(segment2)
    end

  end

  describe "#get" do

    it "gets the value in the data according to row and column" do
      fleet_board.set(0, 0, "value")

      expect(fleet_board.get(0, 0)).to eq("value")
    end

  end

  describe "#set" do

    it "sets the value in the data according to row and column" do
      fleet_board.set(0, 0, "value")

      data = fleet_board.instance_variable_get("@data")
      expect(data[0][0]).to eq("value")
    end

  end

end
