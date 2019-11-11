require 'require_all'
require_all 'lib'

describe Game do

  let(:user_interface) { instance_double("ConsoleUserInterface") }
  let(:player_builder) { class_double("HumanVsComputerPlayerBuilder") }
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
      allow(player_builder).to receive(:build_players_with_boards_and_ships)
      allow(game_loop).to receive(:loop_through_game)
      allow(game_end).to receive(:handle_game_over)
      allow(user_interface).to receive(:good_bye)
    end

    it "welcomes the user when the game starts" do
      expect(user_interface).to receive(:show_welcome)
      game.start
    end

    describe "the loop to set up the game" do

      it "instantiates the game's players with boards" do
        expect(player_builder).to receive(:build_players_with_boards_and_ships).with(user_interface)
        game.start
      end

      it "initiates the game loop governing how the two players take turns" do
        allow(player_builder).to receive(:build_players_with_boards_and_ships).and_return([player_1, player_2])

        expect(game_loop).to receive(:loop_through_game).with(player_1, player_2)
        game.start
      end


      it "asks the user whether it wants to play again after there is a winner" do
        allow(player_builder).to receive(:build_players_with_boards_and_ships).and_return([player_1, player_2])
        allow(game_loop).to receive(:loop_through_game).with(player_1, player_2).and_return(player_1)

        expect(game_end).to receive(:handle_game_over).with(user_interface, player_1)
        game.start
      end

      it "repeats until the user does not want to play anymore" do
        allow(game_end).to receive(:handle_game_over).and_return(true, true, false) 

        expect(player_builder).to receive(:build_players_with_boards_and_ships).exactly(3).times
        expect(game_loop).to receive(:loop_through_game).exactly(3).times
        expect(game_end).to receive(:handle_game_over).exactly(3).times
        game.start
      end

    end

    it "displays a good bye message to the user once the user does not want to play again" do
        allow(game_end).to receive(:handle_game_over).with(user_interface, player_1).and_return(false)

        expect(user_interface).to receive(:good_bye)
        game.start
    end

  end

end
