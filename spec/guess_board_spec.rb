require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_response.rb'

describe GuessBoard do

  let (:guess_board) { GuessBoard.new }

  describe "#update_with" do

    it "parses row, column, and hit-status from its arguments coordinate_guess and response, and updates the data" do
      coordinate_guess = Coordinate.new("a", "1")
      response = instance_double("GuessResponse", "hit?" => true, "ship_sunk?" => false)
      
      guess_board.update_with(coordinate_guess, response)

      expect(guess_board.data[:a][0]).to eq(true)
    end

    it "updates the list of sunk ships and unsunk ships if the response indicates that a ship has been sunk" do
      coordinate_guess = Coordinate.new("a", "1")
      response = instance_double("GuessResponse")
      allow(response).to receive("hit?").and_return(true)
      allow(response).to receive("ship_sunk?").and_return(true)
      allow(response).to receive("ship_type").and_return("Battleship")
      
      guess_board.update_with(coordinate_guess, response)

      expect(guess_board.sunk_ships).to include("Battleship")
      expect(guess_board.unsunk_ships).to eq(["Carrier", "Destroyer", "Submarine", "Patrol Boat"])
    end

  end

end
