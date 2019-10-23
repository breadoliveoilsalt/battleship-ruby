require_relative '../lib/guess_board.rb'
require_relative '../lib/board_data.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_response.rb'

describe GuessBoard do

  describe "#new" do

    it "requires a data representation to be passed in" do
      expect { GuessBoard.new }.to raise_error(ArgumentError)
    end

  end

  let (:data_double) { instance_double("BoardData") }
  let (:guess_board) { GuessBoard.new(
    board_data: data_double
    ) }

  describe "#update_with" do

    it "parses row, column, and hit-status from its arguments coordinate_guess and response, and it passes row, column, and hit-status to data#update_data" do
      coordinate_guess = Coordinate.new("a", "1")
      response = instance_double("GuessResponse", "hit?" => true)
      allow(data_double).to receive(:update_data).with(:a, 0, true).and_return(true)

      result = guess_board.update_with(coordinate_guess, response)

      expect(result).to eq(true)
    end

  end

end
