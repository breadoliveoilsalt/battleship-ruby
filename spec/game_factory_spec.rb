require 'require_all'
require_all 'lib'

describe GameFactory do

  let(:game_factory) { GameFactory.new }

  describe "#build_players_with_boards_and_ships" do

    it "returns a human player and a computer player" do
      result = game_factory.build_players_with_boards_and_ships

      expect(result[0]).to be_a(HumanPlayer)
      expect(result[1]).to be_a(ComputerPlayer)
    end

    describe "the returned human player" do

      it "has a guess board" do
        human_player = game_factory.build_players_with_boards_and_ships[0]
        
        expect(human_player.guess_board).to be_a(GuessBoard)
      end

    end

    describe "the returned computer player" do

      it "has a fleet placement board" do
        computer_player = game_factory.build_players_with_boards_and_ships[1]
        
        expect(computer_player.fleet_board).to be_a(FleetPlacementBoard)
      end

    end

    describe "the computer player's fleet placement board" do

      it "has five ships" do
        computer_player = game_factory.build_players_with_boards_and_ships[1]
        
        expect(computer_player.fleet_board.ships.length).to eq(5)
      end


      it "has 17 ship segments recorded in its data" do
        computer_player = game_factory.build_players_with_boards_and_ships[1]
        
        segment_count = 0
        computer_player.fleet_board.data.each do | row, columns |
          columns.each do | column |
            if column.is_a?(ShipSegment)
              segment_count += 1
            end
          end
        end
        
        expect(segment_count).to eq(17)
      end
    end
  end
end
