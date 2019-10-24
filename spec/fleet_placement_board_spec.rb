require_relative '../lib/fleet_placement_board.rb'
require_relative '../lib/ship.rb'

describe FleetPlacementBoard do

  let(:fleet_placement_board) { FleetPlacementBoard.new }

  describe "#ships" do

    it "defaults to an empty array" do
      expect(fleet_placement_board.ships).to eq([ ])
    end

  end

  describe "#set_ships" do

    it "sets the return value of #ships with the argument passed in" do
      ships = [double("ship 1"), double("ship 2")]

      fleet_placement_board.set_ships(ships)

      expect(fleet_placement_board.ships).to eq(ships)
    end

    it "returns self" do
      ships = [double("ship 1"), double("ship 2")]

      result = fleet_placement_board.set_ships(ships)

      expect(result).to eq(ships)
    end

  end

  describe "#all_ships_sunk?" do 
    
    it "returns true when all ships respond to #sunk? with true" do 
      ship1 = instance_double("ship", :sunk? => true)
      ship2 = instance_double("ship", :sunk? => true)
      fleet_placement_board.set_ships([ship1, ship2])

      result = fleet_placement_board.all_ships_sunk?

      expect(result).to eq(true)
    end
    
    it "returns false when one ship respond to #sunk? with false" do 
      ship1 = instance_double("ship", :sunk? => true)
      ship2 = instance_double("ship", :sunk? => false)
      fleet_placement_board.set_ships([ship1, ship2])

      result = fleet_placement_board.all_ships_sunk?

      expect(result).to eq(false)
    end

  end

  describe "#data" do

    it "defaults to a hash with keys for the letters 'a' through 'j', each with a value of an array filled with 10 nils" do 
      expected_result = {
        a: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        b: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        c: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        d: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        e: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        f: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        g: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        h: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        i: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        j: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
      }
      
      expect(fleet_placement_board.data).to eq(expected_result)
    end

  end
end
