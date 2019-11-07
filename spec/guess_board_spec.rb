require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_response.rb'
require_relative '../lib/board.rb'

describe GuessBoard do

  let (:guess_board) { GuessBoard.new }

  describe "#update_with" do

    it "parses row, column, and hit-status from its arguments coordinate_guess and response, and updates the data" do
      coordinate_guess = Coordinate.new(0, 0)
      response = instance_double("GuessResponse", "hit?" => true, "ship_sunk?" => false)
      
      guess_board.update_with(coordinate_guess, response)

      expect(guess_board.data[0][0]).to eq(true)
    end

    it "updates the list of sunk ships and unsunk ships if the response indicates that a ship has been sunk" do
      coordinate_guess = Coordinate.new(0, 0)
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
      guess_board.instance_variable_set("@data", 
        [
          [nil, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, true],
          [false, true, true, true, true, true, true, true, true, nil]
        ]
      )

      empty_coordinate_1 = Coordinate.new(0, 0)
      empty_coordinate_2 = Coordinate.new(9, 9)

      result = guess_board.get_empty_coordinate
      
      expect(result).to eq(empty_coordinate_1).or eq(empty_coordinate_2)
    end

  end
  
  describe "#get" do

    it "gets the value in the data according to row and column" do
      guess_board.set(0, 0, "value")

      expect(guess_board.get(0, 0)).to eq("value")
    end

  end

  describe "#set" do

    it "sets the value in the data according to row and column" do
      guess_board.set(0, 0, "value")

      data = guess_board.instance_variable_get("@data")
      expect(data[0][0]).to eq("value")
    end

  end

end
