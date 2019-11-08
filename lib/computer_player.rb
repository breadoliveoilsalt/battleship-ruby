require_relative './guess_response.rb'
require_relative './coordinate.rb'
require_relative './ai_for_making_guesses.rb'

class ComputerPlayer

  attr_reader :fleet_board, :guess_board

  def initialize(fleet_board:, guess_board:, ai_for_making_guesses: AIForMakingGuesses.new)
    @fleet_board = fleet_board
    @guess_board = guess_board
    @ai_for_making_guesses = ai_for_making_guesses
  end

  def make_guess
    @ai_for_making_guesses.make_guess(guess_board)
  end

  def respond_to_guess(coordinate_guess)
    fleet_board.update_with(coordinate_guess)
    generate_response_to(coordinate_guess)
  end
  
  def generate_response_to(coordinate_guess)
    occupying_ship = fleet_board.find_ship(coordinate_guess)
    if !occupying_ship
      GuessResponse.respond_with_miss
    elsif occupying_ship.sunk?
      GuessResponse.respond_with_hit.add_ship_sunk(occupying_ship.type)
    else
      GuessResponse.respond_with_hit
    end
  end

  def note_response(coordinate_guess, guess_response)
    guess_board.update_with(coordinate_guess, guess_response)
  end

  def lost_game?
    fleet_board.all_ships_sunk?
  end

end
