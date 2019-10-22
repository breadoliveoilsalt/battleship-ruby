require_relative '../lib/guess_board.rb'
require_relative '../lib/board_data.rb'

describe GuessBoard do

  describe "#new" do

    it "requires a data representation to be passed in" do
      expect { GuessBoard.new }.to raise_error(ArgumentError)
    end

  end

  let (:data_representation_double) { instance_double("BoardData") }
  let (:guess_board) { GuessBoard.new(
    data_representation: data_representation_double
    ) }

  describe "#update_data" do

    it "calls #update_data on @data_representation, passing its own arguments, coordinate_guess and response" do
      expected_result = "Expected Result"
      coordinate_guess = double("coordinate")
      response = double("response")
      allow(data_representation_double).to receive(:update_data).with(coordinate_guess, response).and_return(expected_result)

      result = guess_board.update_data(coordinate_guess, response)

      expect(result).to eq(expected_result)
    end

  end

  describe "#data" do

    it "calls #data on @data_representation" do
      expected_result = "Expected Result"
      allow(data_representation_double).to receive(:data).and_return(expected_result)

      result = guess_board.data

      expect(result).to eq(expected_result)
    end

  end

end
