require 'require_all'
require_all 'lib'

describe Game do

  let(:user_interface) { instance_double("ConsoleUserInterface") }
  let(:player_builder) { class_double("PlayerBuilder") }
  let(:game_loop) { class_double("GameLoop") }
  let(:game_end) { class_double("GameEnd") }
  let(:player_1) { instance_double("HumanPlayer") }
  let(:player_2) { instance_double("ComputerPlayer") }

  let(:game) { Game.new(
    user_interface: user_interface,
    player_builder: player_builder,
    game_loop: game_loop,
    game_end: game_end
  ) }

  describe "#start" do

    before(:each) do
      allow(user_interface).to receive(:show_welcome)
      allow(player_builder).to receive(:new).with(user_interface).and_return(instance_double("PlayerBuilder"))
#[player_1, player_2])
      allow(game_loop).to receive(:new).with(player_1, player_2).and_return(player_1)
      allow(game_end).to receive(:new).with(user_interface)
      allow(user_interface).to receive(:good_bye)

    end

    it "welcomes the user when the game starts" do

      expect(user_interface).to receive(:show_welcome)
      game.start

    end

    describe "the Game loop" do

      it "instantiates the game's players with boards" do

      end

      it "initiates the game loop governing how the two players take turns" do

      end


      it "asks the user whether it wants to play again after there is a winner" do

      end

      it "instantiates new players with boards and a new game loop if the user wants to play again" do

      end

    end

    it "displays a good bye message to the user once the user does not want to play again" do


    end

  end

end
