require 'require_all'
require_all 'lib'

describe PlayerBuilder do

  let(:user_interface) { instance_double("ConsoleUserInterface") }
  let(:player_builder) { PlayerBuilder.new(user_interface) }

  describe "#build_players_with_boards_and_ships" do

    before(:each) do 
      allow(user_interface).to receive(:show_potential_fleet_board)
      allow(user_interface).to receive(:get_board_ok).and_return(true)
    end


    it "returns a human player and a computer player" do
      result = player_builder.build_players_with_boards_and_ships

      expect(result[0]).to be_a(HumanPlayer)
      expect(result[1]).to be_a(ComputerPlayer)
    end

    describe "the returned human player" do

      it "has a guess board" do
        human_player = player_builder.build_players_with_boards_and_ships[0]
        
        expect(human_player.guess_board).to be_a(GuessBoard)
      end
      
      it "has a fleet placement board" do
        human_player = player_builder.build_players_with_boards_and_ships[1]
        
        expect(human_player.fleet_board).to be_a(FleetBoard)
      end
    
      describe "the human player's fleet placement board" do

        it "has five ships" do
          human_player = player_builder.build_players_with_boards_and_ships[1]
          
          expect(human_player.fleet_board.ships.length).to eq(5)
        end

        it "has 17 ship segments recorded in its data" do
          human_player = player_builder.build_players_with_boards_and_ships[1]
          
          segment_count = 0
          human_player.fleet_board.data.each do | row |
            row.each do | column |
              if column.is_a?(ShipSegment)
                segment_count += 1
              end
            end
          end
          
          expect(segment_count).to eq(17)
        end
      end

    end

    describe "the returned computer player" do

      it "has a fleet placement board" do
        computer_player = player_builder.build_players_with_boards_and_ships[1]
        
        expect(computer_player.fleet_board).to be_a(FleetBoard)
      end

    end

    describe "the computer player's fleet placement board" do

      it "has five ships" do
        computer_player = player_builder.build_players_with_boards_and_ships[1]
        
        expect(computer_player.fleet_board.ships.length).to eq(5)
      end


      it "has 17 ship segments recorded in its data" do
        computer_player = player_builder.build_players_with_boards_and_ships[1]
        
        segment_count = 0
        computer_player.fleet_board.data.each do | row |
          row.each do | column |
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
