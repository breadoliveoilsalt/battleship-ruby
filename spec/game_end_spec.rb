require_relative '../lib/game_end.rb'
require_relative '../lib/console_user_interface.rb'

describe GameEnd do

  let(:user_interface) { instance_double("ConsoleUserInterface") }
  let(:game_end) { GameEnd }
  let(:winner) { double("winner") }

  describe "#handle_game_over" do

    before(:each) do
      allow(user_interface).to receive(:announce_winner)
      allow(user_interface).to receive(:get_play_again)
    end

    it "tells the user interface to announce the winner" do 
      expect(user_interface).to receive(:announce_winner).with(winner)
        
      game_end.handle_game_over(user_interface, winner)
    end


    it "tells the user interface to ask whether the user wants to play again" do 
      expect(user_interface).to receive(:get_play_again)
        
      game_end.handle_game_over(user_interface, winner)
    end

    it "returns the return value from getting whether the user wants to play again from the user interface" do
      allow(user_interface).to receive(:get_play_again).and_return(true)

      result = game_end.handle_game_over(user_interface, winner)
      expect(result).to eq(true)
    end
    
  end

end
