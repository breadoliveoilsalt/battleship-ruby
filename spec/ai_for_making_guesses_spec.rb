require_relative '../lib/ai_for_making_guesses.rb'
require_relative '../lib/coordinate.rb'
require_relative '../lib/guess_board.rb'

describe AIForMakingGuesses do

  let(:ai) { AIForMakingGuesses.new }
  
  describe "#make_guess" do

    it "returns a random coordinate if the guess board has no hits or misses on it" do
      10.times do
        guess_board = GuessBoard.new  
        result = ai.make_guess(guess_board)

        expect(result).to be_a(Coordinate)
        expect(result.row).to be >= 0
        expect(result.row).to be <= 9
        expect(result.column).to be >= 0
        expect(result.column).to be <= 9
      end
    end

    it "returns a random coordinate other than a miss if the guess board has misses but no hits" do 
      10.times do
        guess_board = GuessBoard.new  
        guess_board.set(0, 0, false)
        guess_board.set(9, 9, false)
        guess_board.set(9, 0, false)
        guess_board.set(0, 9, false)
        result = ai.make_guess(guess_board)

        expect(result).not_to be(Coordinate.new(0, 0))
        expect(result).not_to be(Coordinate.new(9, 9))
        expect(result).not_to be(Coordinate.new(9, 0))
        expect(result).not_to be(Coordinate.new(0, 9))
      end
    end

    it "returns a coordinate next to a hit, if the hit is not surrounded by misses or hits" do 
      guess_board = GuessBoard.new
      guess_board.set(1, 1, true)
      guess_board.set(0, 1, false)
      guess_board.set(1, 2, false)
      guess_board.set(2, 1, false)

      result = ai.make_guess(guess_board)
      
      expect(result).to eq(Coordinate.new(1, 0))
    end
    
    it "ignores hits that are surrounded by hits and misses, instead returning a random open coordinate" do
      10.times do
        guess_board = GuessBoard.new
        guess_board.set(0, 0, true)
        guess_board.set(0, 1, true)
        guess_board.set(1, 0, false)
        guess_board.set(1, 1, false)
        guess_board.set(0, 2, false)

        result = ai.make_guess(guess_board)
      
        expect(result).not_to eq(Coordinate.new(0, 0)) 
        expect(result).not_to eq(Coordinate.new(0, 1)) 
      end
    end

    it "tests the neighbors of a hit for another hit, in a clockwise fashion, starting at the top neighbor" do
      guess_board = GuessBoard.new
      guess_board.set(1, 1, true)

      result_1 = ai.make_guess(guess_board)
      guess_board.set(0, 1, false)

      result_2 = ai.make_guess(guess_board)
      guess_board.set(1, 2, false)
      
      result_3 = ai.make_guess(guess_board)
      guess_board.set(2, 1, false)

      result_4 = ai.make_guess(guess_board)
      
      expect(result_1).to eq(Coordinate.new(0, 1))
      expect(result_2).to eq(Coordinate.new(1, 2))
      expect(result_3).to eq(Coordinate.new(2, 1))
      expect(result_4).to eq(Coordinate.new(1, 0))
    end

  end

end
