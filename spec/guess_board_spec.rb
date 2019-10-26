require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_response.rb'

describe GuessBoard do

  let (:guess_board) { GuessBoard.new }

  describe "#update_with" do

    it "parses row, column, and hit-status from its arguments coordinate_guess and response, and updates the data" do
      coordinate_guess = Coordinate.new("a", "1")
      response = instance_double("GuessResponse", "hit?" => true)
      
      guess_board.update_with(coordinate_guess, response)

      expect(guess_board.data[:a][0]).to eq(true)
    end

  end

end
