require_relative '../lib/human_player.rb'
require_relative '../lib/console_user_interface.rb'
require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'
require_relative './fake_user_interface.rb'

describe HumanPlayer do

  describe "#new" do

    it "requires keyword arguments for user_interface and guess_board" do
      expect { HumanPlayer.new }.to raise_error(ArgumentError)
    end

  end

  let(:guess_board) { instance_double("GuessBoard") }
  let (:fake_user_interface) { FakeUserInterface.new }
  let(:fleet_board) { instance_double("FleetBoard") }

  let(:human_player) { HumanPlayer.new(
    user_interface: fake_user_interface,
    guess_board: guess_board,
    fleet_board: fleet_board
  )}

  describe "#make_guess" do

    it "shows the boards and asks the user for a row and column guess" do
      human_player.make_guess

      expect(fake_user_interface.calls).to eq([:show_game, :get_row, :get_column])
    end

    it "returns a coordinate object based on calling #get_row and #get_column on @user_interface" do
      result = human_player.make_guess

      expect(result).to be_a(Coordinate)
      expect(result.row).to eq("a")
      expect(result.column).to eq("1")
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
      
      human_player.respond_to_guess(coordinate_guess)
    end
    
    it "returns a GuessReturn object with #hit? set to false if occupying_ship is nil" do
      coordinate_guess = double
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(nil)
      
      result = human_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(false)
    end

    it "returns a GuessReturn object with #hit? set to true if occupying_ship is not nil" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => false)
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = human_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.hit?).to be(true)
    end

    it "returns a GuessReturn object with #ship_sunk? set to true and a #ship_type if occupying_ship returns true to #sunk?" do
      coordinate_guess = double
      ship_double = double("ship", "sunk?" => true, "type" => "Battleship")
      allow(fleet_board).to receive(:find_ship).with(coordinate_guess).and_return(ship_double)
      
      result = human_player.respond_to_guess(coordinate_guess)

      expect(result).to be_a(GuessResponse)
      expect(result.ship_sunk?).to be(true)
      expect(result.ship_type).to eq("Battleship")
    end

    it "tells the user_interface to record the user response to the coordinate and show the game" do
      coordinate_guess = double
      human_player.respond_to_guess(coordinate_guess)

      expect(fake_user_interface.calls).to eq([:record_response, :show_game])
    end

  end

  describe "#note_response" do

    before(:each) do
      allow(guess_board).to receive(:update_with)
    end

    it "calls #update_with on @guess_board with its own arguments for coordinate_guess and guess_response" do
      coordinate_guess = double("coordinate guess")
      guess_response = double("guess response")

      expect(guess_board).to receive(:update_with).with(coordinate_guess, guess_response)

      human_player.note_response(coordinate_guess, guess_response)
    end

    it "tells the user interface to record the result of the guess and show the game" do
      coordinate_guess = double("coordinate guess")
      guess_response = double("guess response")

      human_player.note_response(coordinate_guess, guess_response)
      expect(fake_user_interface.calls).to eq([:record_result_of_guess, :show_game])
    end

  end

  describe "#lost_game?" do

    it "returns the response from asking the fleet board if all ships are sunk" do 
      
      allow(fleet_board).to receive("all_ships_sunk?").and_return(true)

      result = human_player.lost_game?

      expect(result).to eq(true)
    end
    
  end

end

