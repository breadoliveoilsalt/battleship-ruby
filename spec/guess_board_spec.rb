require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_response.rb'
require_relative '../lib/board.rb'

describe GuessBoard do

  let (:guess_board) { GuessBoard.new }

  describe "#update_with" do

    it "parses row, column, and hit-status from its arguments coordinate_guess and response, and updates the data" do
      coordinate_guess = Coordinate.new("a", "1")
      response = instance_double("GuessResponse", "hit?" => true, "ship_sunk?" => false)
      
      guess_board.update_with(coordinate_guess, response)

      expect(guess_board.board.get(:a, 0)).to eq(true)

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

  describe "#get_empty_coordinate" do

    it "returns a random coordinate that has not been guessed before" do
      guess_board.set_data(
        { 
          a: [nil, true, true, true, true, true, true, true, true, true],
          b: [false, true, true, true, true, true, true, true, true, true],
          c: [false, true, true, true, true, true, true, true, true, true],
          d: [false, true, true, true, true, true, true, true, true, true],
          e: [false, true, true, true, true, true, true, true, true, true],
          f: [false, true, true, true, true, true, true, true, true, true],
          g: [false, true, true, true, true, true, true, true, true, true],
          h: [false, true, true, true, true, true, true, true, true, true],
          i: [false, true, true, true, true, true, true, true, true, true],
          j: [false, true, true, true, true, true, true, true, true, nil]
        }
      )

      empty_coordinate_1 = Coordinate.new("a", "1")
      empty_coordinate_2 = Coordinate.new("j", "10")

      result = guess_board.get_empty_coordinate
      
      expect(result).to eq(empty_coordinate_1).or eq(empty_coordinate_2)
    end

  end

end
