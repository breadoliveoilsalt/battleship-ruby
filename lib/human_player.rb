require_relative '../lib/coordinate.rb'

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
  
  def note_response(coordinate_guess, guess_response)
    guess_board.update_with(coordinate_guess, guess_response)
    user_interface.show_result_of_guess(coordinate_guess, guess_response)
  end
  
end
