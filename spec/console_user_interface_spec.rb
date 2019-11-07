require 'require_all'
require_all 'lib'

describe ConsoleUserInterface do

  let(:output_stream_double) { instance_double("ConsoleOutputStream") }
  let(:input_stream_double) { instance_double("ConsoleInputStream") }

  let(:user_interface) { ConsoleUserInterface.new(
    output_stream: output_stream_double,
    input_stream: input_stream_double
  ) }

  before(:each) do
    allow(output_stream_double).to receive(:render)
    allow(input_stream_double).to receive(:read_line)
  end

  describe "#new" do

    it "requires an output_stream and input_stream to be passed in as keyword arguments" do
      expect { ConsoleUserInterface.new }.to raise_error(ArgumentError)
    end

  end

  describe "#get_row" do
    
    it "reads a line from the input stream" do
      allow(input_stream_double).to receive(:read_line).and_return("a")

      expect(input_stream_double).to receive(:read_line)
      user_interface.get_row
    end
  
    it "only returns a valid row between 0 and 9 based on whether the user enters the letters a through j" do
      allow(input_stream_double).to receive(:read_line).and_return("z", "56", "", "j")

      expect(user_interface.get_row).to eq(9)
      user_interface.get_row
    end
    
  end

  describe "#get_column" do
    
    it "reads a line from the input stream" do
      allow(input_stream_double).to receive(:read_line).and_return("1")

      expect(input_stream_double).to receive(:read_line)
      user_interface.get_column
    end
  
    it "only returns a valid column between 0 and 9 based on whether the user enters a number from 1 to 10" do
      allow(input_stream_double).to receive(:read_line).and_return("a", "56", "", "1")

      expect(user_interface.get_column).to eq(0)
      user_interface.get_column
    end
    
  end

  describe "#get_play_again" do
    
    it "returns true if the user enters 'y' from the input stream" do
      allow(input_stream_double).to receive(:read_line).and_return("y")

      expect(user_interface.get_play_again).to eq(true)
      user_interface.get_play_again
    end
  
    it "returns false if the user enters 'n' from the input stream" do
      allow(input_stream_double).to receive(:read_line).and_return("n")

      expect(user_interface.get_play_again).to eq(false)
      user_interface.get_play_again
    end
    
    it "keeps calling read line on the input stream until the user enters 'y'" do
      allow(input_stream_double).to receive(:read_line).and_return("1", "a", "", "y")

      expect(user_interface.get_play_again).to eq(true)
      user_interface.get_play_again
    end
    
    it "alternatively keeps calling read line on the input stream until the user enters 'n'" do
      allow(input_stream_double).to receive(:read_line).and_return("1", "a", "", "n")

      expect(user_interface.get_play_again).to eq(false)
      user_interface.get_play_again
    end

  end

  describe "#announce_winner" do
  
    it "passes a congratulations message to the output stream if the winner is a HumanPlayer" do

      expect(output_stream_double).to receive(:render).with("\nCongratulations! You won!\n")
      user_interface.announce_winner(HumanPlayer.new(user_interface: double, guess_board: double, fleet_board: double))

  end

    it "passes a losing message to the output stream if the winner is not a HumanPlayer" do

      expect(output_stream_double).to receive(:render).with("\nSorry, the other player sunk all your ships.\n")
      user_interface.announce_winner(instance_double("ComputerPlayer"))
    end
    
  end
end
