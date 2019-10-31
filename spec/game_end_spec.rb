require_relative '../lib/game_end.rb'
require_relative '../lib/console_user_interface.rb'

describe GameEnd do

  let(:user_interface_double) { instance_double("ConsoleUserInterface") }
  let(:game_end) { GameEnd.new(user_interface_double) }
  let(:winner_double) { double("winner") }

  describe "#handle_game_over" do

    before(:each) do
      allow(user_interface_double).to receive(:announce_winner)
      allow(user_interface_double).to receive(:get_play_again)
    end

    it "tells the user interface to announce the winner" do 
      expect(user_interface_double).to receive(:announce_winner).with(winner_double)
        
      game_end.handle_game_over(winner_double)
    end


    it "tells the user interface to ask whether the user wants to play again" do 
      expect(user_interface_double).to receive(:get_play_again)
        
      game_end.handle_game_over(winner_double)
    end

    it "returns the return value from getting whether the user wants to play again from the user interface" do
      allow(user_interface_double).to receive(:get_play_again).and_return(true)

      result = game_end.handle_game_over(winner_double)
      expect(result).to eq(true)
    end
    
  end

end
