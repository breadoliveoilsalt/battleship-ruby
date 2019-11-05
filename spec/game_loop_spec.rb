require 'require_all'
require_all 'lib'

describe GameLoop do

  let(:human_player_double) { instance_double("HumanPlayer") }
  let(:computer_player_double) { instance_double("ComputerPlayer") }
  
  let(:game_loop) { GameLoop.new(human_player_double, computer_player_double) }

  describe "#loop_through_game - testing approach 1 - assert return value" do

    before(:each) do
      allow(human_player_double).to receive(:make_guess)
      allow(computer_player_double).to receive(:respond_to_guess)
      allow(human_player_double).to receive(:note_response)
    end

    it "returns the current player if the other player has lost the game" do 
      allow(computer_player_double).to receive("lost_game?").and_return(false, false, true)
      
      winner = game_loop.loop_through_game

      expect(winner).to eq(human_player_double)
    end
  end

  describe "#loop_through_game - testing approach 2 - method calls" do

    before(:each) do
      allow(human_player_double).to receive(:make_guess)
      allow(computer_player_double).to receive(:respond_to_guess)
      allow(human_player_double).to receive(:note_response)
    end

    it "executes a loop that asks the human player for a guess, then the computer player to respond, then the human player to note the response" do
      allow(computer_player_double).to receive("lost_game?").and_return(false, true)
      
      expect(human_player_double).to receive(:make_guess).ordered
      expect(computer_player_double).to receive(:respond_to_guess).ordered
      expect(human_player_double).to receive(:note_response).ordered
      game_loop.loop_through_game
    end

    describe "until the computer loses" do
    
      it "asks the human_player_double to make a guess" do
        allow(computer_player_double).to receive("lost_game?").and_return(false, false, false, true)

        expect(human_player_double).to receive(:make_guess).exactly(3).times
        game_loop.loop_through_game
      end

      it "asks the computer player to respond to the return value from the human player's guess" do 
        allow(computer_player_double).to receive("lost_game?").and_return(false, false, false, true)
        coordinate_1 = Coordinate.new("a", "1")
        coordinate_2 = Coordinate.new("a", "2")
        coordinate_3 = Coordinate.new("a", "3")
        allow(human_player_double).to receive(:make_guess).and_return(coordinate_1, coordinate_2, coordinate_3)

        expect(computer_player_double).to receive(:respond_to_guess).with(coordinate_1).exactly(1).time.ordered
        expect(computer_player_double).to receive(:respond_to_guess).with(coordinate_2).exactly(1).time.ordered
        expect(computer_player_double).to receive(:respond_to_guess).with(coordinate_3).exactly(1).time.ordered
        game_loop.loop_through_game
      end

      it "asks the human player to note its coorindate and the repsonse of the computer player to the guess coordinate" do 
        allow(computer_player_double).to receive("lost_game?").and_return(false, false, false, true)

        coordinate_1 = Coordinate.new("a", "1")
        coordinate_2 = Coordinate.new("a", "2")
        coordinate_3 = Coordinate.new("a", "3")
        allow(human_player_double).to receive(:make_guess).and_return(coordinate_1, coordinate_2, coordinate_3)

        response_1 = instance_double("GuessResponse")
        response_2 = instance_double("GuessResponse")
        response_3 = instance_double("GuessResponse")
        allow(computer_player_double).to receive(:respond_to_guess).with(coordinate_1).and_return(response_1)
        allow(computer_player_double).to receive(:respond_to_guess).with(coordinate_2).and_return(response_2)
        allow(computer_player_double).to receive(:respond_to_guess).with(coordinate_3).and_return(response_3)

        expect(human_player_double).to receive(:note_response).with(coordinate_1, response_1).ordered
        expect(human_player_double).to receive(:note_response).with(coordinate_2, response_2).ordered
        expect(human_player_double).to receive(:note_response).with(coordinate_3, response_3).ordered
        game_loop.loop_through_game
      end
    end
  end
end
