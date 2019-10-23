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

  let(:guess_board_double) { instance_double("GuessBoard") }
  let (:fake_user_interface) { FakeUserInterface.new }

  let(:human_player) { HumanPlayer.new(
    user_interface: fake_user_interface,
    guess_board: guess_board_double
  )}

  describe "#make_guess" do

    it "calls #show_board, #get_row, and #get_column on @user_interface to show the board and get the user's row and column selection" do
      human_player.make_guess

      expect(fake_user_interface.calls).to eq([:show_board, :get_row, :get_column])
    end

    it "returns a coordinate object based on calling #get_row and #get_column on @user_interface" do
      result = human_player.make_guess

      expect(result).to be_a(Coordinate)
      expect(result.row).to eq("a")
      expect(result.column).to eq("1")
    end

  end

  describe "#note_response" do

    before(:each) do
      allow(guess_board_double).to receive(:update_with)
    end

    it "calls #update_with on @guess_board with its own arguments for coordinate_guess and guess_response" do
      coordinate_guess = double("coordinate guess")
      guess_response = double("guess response")

      expect(guess_board_double).to receive(:update_with).with(coordinate_guess, guess_response)

      human_player.note_response(coordinate_guess, guess_response)
    end

    it "calls #record_result_of_guess on @user_interface and passes its own arguments for coordinate_guess and guess_response" do
      coordinate_guess = double("coordinate guess")
      guess_response = double("guess response")

      human_player.note_response(coordinate_guess, guess_response)
      expect(fake_user_interface.calls).to eq([:record_result_of_guess])
    end

  end
end

