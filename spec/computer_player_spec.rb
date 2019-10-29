require 'require_all'
require_all 'lib'

describe ComputerPlayer do

  let(:fleet_board_double) { instance_double("FleetPlacementBoard") } 
  let(:ai_double) { instance_double("AI") }
  
  let(:computer_player) { ComputerPlayer.new(
      fleet_board: fleet_board_double,
      ai: ai_double
      )
  }

  describe "#new" do

    it "requires keyword arguments" do
      expect{ ComputerPlayer.new }.to raise_error(ArgumentError)
    end

  end

  describe "#place_ships" do

    it "calls @ai.pick_coordinates_for_ships with @ships as an argument" do
      expect(ai_double).to receive(:pick_coordinates_for_ships).with(fleet_board_double)
      computer_player.place_ships
    end

  end

  describe "#respond to guess" do

    before(:each) do
      coordinate_guess = double
      allow(fleet_board_double).to receive(:update_data_with_guess)
      allow(fleet_board_double).to receive(:find_ship)
    end
      
    it "calls @fleet_board.find_ship with a coordinate_guess to see if there is an occupying_ship" do
      coordinate_guess = double
      expect(fleet_board_double).to receive(:find_ship).with(coordinate_guess)
      
      computer_player.respond_to_guess(coordinate_guess)
    end
    
    it "returns a GuessReturn object with #hit? set to false if occupying_ship is nil" do
      coordinate_guess = double
      allow(fleet_board_double).to receive(:find_ship).with(coordinate_guess).and_return(nil)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(false)
    end

    it "returns a GuessReturn object with #hit? set to true if occupying_ship is not nil" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => false)
      allow(fleet_board_double).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(true)
    end

    it "returns a GuessReturn object with #ship_sunk? set to true and a #ship_type if occupying_ship returns true to #sunk?" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => true, "type" => "Battleship")
      allow(fleet_board_double).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.ship_sunk?).to be(true)
      expect(result.ship_type).to eq("Battleship")
    end

  end

  describe "#lost_game?" do

    it "calls @fleet_board.all_ships_sunk?" do 
      expect(fleet_board_double).to receive("all_ships_sunk?")
      computer_player.lost_game?
    end
    
  end
end
