require_relative '../lib/human_player.rb'
require_relative '../lib/console_user_interface.rb'
require_relative '../lib/guess_board.rb'
require_relative '../lib/coordinate.rb'

describe HumanPlayer do

  describe "#new" do

    it "requires keyword arguments for user_interface, guess_board, and coordinate_model" do

    expect { HumanPlayer.new }.to raise_error(ArgumentError)

    end

  end

  let(:user_interface_double) { instance_double("ConsoleUserInterface") }
  let(:guess_board_double) { instance_double("GuessBoard") }
  let(:coordinate_builder_double) { instance_double("Coordinate") }

  let(:human_player) { HumanPlayer.new(
    user_interface: user_interface_double,
    guess_board: guess_board_double,
    coordinate_builder: coordinate_builder_double
  )}

  xdescribe "#make_guess" do

    before(:each) do 
      allow(user_interface_double).to receive(:show_board)
      allow(user_interface_double).to receive(:get_row)
      allow(user_interface_double).to receive(:get_column)
      allow(coordinate_builder_double).to receive(:with_row)
      allow(coordinate_builder_double).to receive(:with_column)
    end

    it "shows the guess board to the user by calling #show_board on @user_interface with @guess_board as an argument" do 
      allow(user_interface_double).to receive(:show_board).with(guess_board_double).and_return(true)

      result = human_player.make_guess
    end

    it "returns a coordinate object based on calling #get_row and #get_column on @user_interface" do

      
    end

  end


  describe "#update_guess_board" do

    it "calls #update_with on @guess_board with its own argument for guess_response" do
      guess_response = double("guess response")
      allow(guess_board_double).to receive(:update_with).with(guess_response).and_return(true)

      result = human_player.update_guess_board(guess_response)

    end

    xit "calls #record_result_of_guess on @user_interface and passes its own argument for guess_response" do

    end
  end

end
