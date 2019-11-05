require_relative './guess_response.rb'
require_relative './coordinate.rb'

class HumanPlayer

  attr_reader :user_interface, :guess_board, :fleet_board

  attr_accessor :cheat_board

  def initialize(user_interface:, guess_board:, fleet_board:)
    @user_interface = user_interface
    @guess_board = guess_board
    @fleet_board = fleet_board
  end

  def make_guess
    user_interface.show_boards(guess_board, fleet_board)
    row = user_interface.get_row
    column = user_interface.get_column
    Coordinate.new(row, column)
  end

  def respond_to_guess(coordinate_guess)
    fleet_board.update_data_with_guess(coordinate_guess)
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
    user_interface.show_result_of_guess(coordinate_guess, guess_response)
  end
  
end
