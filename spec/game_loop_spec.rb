require 'require_all'
require_all 'lib'

describe GameLoop do

  let(:player_1) { instance_double("HumanPlayer") }
  let(:player_2) { instance_double("ComputerPlayer") }
  
  let(:game_loop) { GameLoop.new(player_1, player_2) }

  describe "#loop_through_game" do

    before(:each) do
      allow(player_1).to receive(:make_guess)
      allow(player_1).to receive(:respond_to_guess)
      allow(player_1).to receive(:note_response)
      allow(player_2).to receive(:make_guess)
      allow(player_2).to receive(:respond_to_guess)
      allow(player_2).to receive(:note_response)
    end

    it "plays the game, switching between players until a player wins" do
      allow(player_2).to receive("lost_game?").and_return(false, false, true)
      allow(player_1).to receive("lost_game?").and_return(false, false, false)

      expect(player_1).to receive(:make_guess).ordered
      expect(player_2).to receive(:respond_to_guess).ordered
      expect(player_1).to receive(:note_response).ordered

      expect(player_2).to receive(:make_guess).ordered
      expect(player_1).to receive(:respond_to_guess).ordered
      expect(player_2).to receive(:note_response).ordered

      game_loop.loop_through_game
    end

    it "returns the winner" do 
      allow(player_2).to receive("lost_game?").and_return(false)
      allow(player_1).to receive("lost_game?").and_return(true)
      
      winner = game_loop.loop_through_game

      expect(winner).to eq(player_1)
    end

    describe "a turn in the game" do

      before(:each) do 
        allow(player_2).to receive("lost_game?").and_return(false)
        allow(player_1).to receive("lost_game?").and_return(true)

        allow(player_1).to receive(:make_guess)
        allow(player_2).to receive(:respond_to_guess)
        allow(player_1).to receive(:note_response)
      end

      it "asks the current player to make a guess" do
        expect(player_1).to receive(:make_guess)
        game_loop.loop_through_game
      end

      it "asks asks the other player to respond to the guess" do
        coordinate = Coordinate.new("a", "1")
        allow(player_1).to receive(:make_guess).and_return(coordinate)

        expect(player_2).to receive(:respond_to_guess).with(coordinate)
        game_loop.loop_through_game
      end

      it "asks the current player to note the response from the other player to its cguess coordinate" do
        coordinate = Coordinate.new("a", "1")
        allow(player_1).to receive(:make_guess).and_return(coordinate)

        response = instance_double("GuessResponse")
        allow(player_2).to receive(:respond_to_guess).with(coordinate).and_return(response)

        expect(player_1).to receive(:note_response).with(coordinate, response)
        game_loop.loop_through_game
      end

    end

  end

end
