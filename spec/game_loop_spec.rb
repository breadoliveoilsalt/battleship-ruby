require 'require_all'
require_all 'lib'

describe GameLoop do

  let(:human_player) { instance_double("HumanPlayer") }
  let(:computer_player) { instance_double("ComputerPlayer") }
  
  let(:game_loop) { GameLoop.new(human_player, computer_player) }

  describe "#loop_through_game" do

    before(:each) do
      allow(human_player).to receive(:make_guess)
      allow(human_player).to receive(:respond_to_guess)
      allow(human_player).to receive(:note_response)
      allow(computer_player).to receive(:make_guess)
      allow(computer_player).to receive(:respond_to_guess)
      allow(computer_player).to receive(:note_response)
    end

    it "plays the game, switching between players until a player wins" do
      allow(computer_player).to receive("lost_game?").and_return(false, false, true)
      allow(human_player).to receive("lost_game?").and_return(false, false, false)

      expect(human_player).to receive(:make_guess).ordered
      expect(computer_player).to receive(:respond_to_guess).ordered
      expect(human_player).to receive(:note_response).ordered

      expect(computer_player).to receive(:make_guess).ordered
      expect(human_player).to receive(:respond_to_guess).ordered
      expect(computer_player).to receive(:note_response).ordered

      game_loop.loop_through_game
    end

    it "returns the winner" do 
      allow(computer_player).to receive("lost_game?").and_return(false)
      allow(human_player).to receive("lost_game?").and_return(true)
      
      winner = game_loop.loop_through_game

      expect(winner).to eq(human_player)
    end

    describe "a turn in the game" do

      before(:each) do 
        allow(computer_player).to receive("lost_game?").and_return(false)
        allow(human_player).to receive("lost_game?").and_return(true)

        allow(human_player).to receive(:make_guess)
        allow(computer_player).to receive(:respond_to_guess)
        allow(human_player).to receive(:note_response)
      end

      it "asks the current player to make a guess" do
        expect(human_player).to receive(:make_guess)
        game_loop.loop_through_game
      end

      it "asks asks the other player to respond to the guess" do
        coordinate = Coordinate.new("a", "1")
        allow(human_player).to receive(:make_guess).and_return(coordinate)

        expect(computer_player).to receive(:respond_to_guess).with(coordinate)
        game_loop.loop_through_game
      end

      it "asks the current player to note the response from the other player to its cguess coordinate" do
        coordinate = Coordinate.new("a", "1")
        allow(human_player).to receive(:make_guess).and_return(coordinate)

        response = instance_double("GuessResponse")
        allow(computer_player).to receive(:respond_to_guess).with(coordinate).and_return(response)

        expect(human_player).to receive(:note_response).with(coordinate, response)
        game_loop.loop_through_game
      end

    end

  end

end
