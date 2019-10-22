require_relative '../lib/coordinate.rb'

class HumanPlayer

  attr_reader :user_interface, :guess_board

  def initialize(user_interface:, guess_board:)
    @user_interface = user_interface
    @guess_board = guess_board
  end

  def make_guess
    user_interface.show_board(guess_board)
    row = user_interface.get_row
    column = user_interface.get_column
    Coordinate.new(row, column)
  end
  
  def note_response(coordinate_guess, guess_response)
    guess_board.update_with(coordinate_guess, guess_response)
    user_interface.record_result_of_guess(coordinate_guess, guess_response)
  end
  
end
