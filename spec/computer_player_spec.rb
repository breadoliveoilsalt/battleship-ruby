require 'require_all'
require_all 'lib'

describe ComputerPlayer do

  let(:fleet_board) { instance_double("FleetBoard") } 
  let(:guess_board) { instance_double("GuessBoard") } 
  let(:ai) { instance_double("AIForMakingGuesses") }
  
  let(:computer_player) { ComputerPlayer.new(
      fleet_board: fleet_board,
      guess_board: guess_board,
      ai_for_making_guesses: ai
      )
  }

  describe "#new" do

    it "requires keyword arguments" do
      expect{ ComputerPlayer.new }.to raise_error(ArgumentError)
    end

  end

  describe "#make_guess" do
  
    it "returns a coordinate by asking the ai for making guesses to make a guess" do
      
      coordinate = Coordinate.new(0, 0)
      allow(ai).to receive(:make_guess).with(guess_board).and_return(coordinate)
      
      result = computer_player.make_guess
      
      expect(result).to eq(coordinate)
    end

  end

  describe "#respond to guess" do

    before(:each) do
      coordinate_guess = double
      allow(fleet_board).to receive(:update_with)
      allow(fleet_board).to receive(:find_ship)
    end
      
    it "calls @fleet_board.find_ship with a coordinate_guess to see if there is an occupying_ship" do
      coordinate_guess = double
      expect(fleet_board).to receive(:find_ship).with(coordinate_guess)
      
      computer_player.respond_to_guess(coordinate_guess)
    end
    
    it "returns a GuessReturn object with #hit? set to false if occupying_ship is nil" do
      coordinate_guess = double
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(nil)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(false)
    end

    it "returns a GuessReturn object with #hit? set to true if occupying_ship is not nil" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => false)
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(true)
    end

    it "returns a GuessReturn object with #ship_sunk? set to true and a #ship_type if occupying_ship returns true to #sunk?" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => true, "type" => "Battleship")
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = computer_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.ship_sunk?).to be(true)
      expect(result.ship_type).to eq("Battleship")
    end

  end

  describe "#note_response" do

    it "tells the fleet board to update with a coordinate guess and response from the other player to that guess" do
      coordinate_guess = double("coordinate guess")
      guess_response = double("guess response")

      expect(guess_board).to receive(:update_with).with(coordinate_guess, guess_response)
      computer_player.note_response(coordinate_guess, guess_response)
    end

  end

  describe "#lost_game?" do

    it "calls @fleet_board.all_ships_sunk?" do 
      expect(fleet_board).to receive("all_ships_sunk?")
      computer_player.lost_game?
    end
    
  end

end
