class HumanPlayer

  attr_reader :user_interface, :guess_board, :coordinate_builder

  def initialize(user_interface:, guess_board:, coordinate_builder:)
    @user_interface = user_interface
    @guess_board = guess_board
    @coordinate_builder = coordinate_builder
  end

  def make_guess
    user_interface.show_board(guess_board)
    row = user_interface.get_row
    column = user_interface.get_column
    coordinate.with_row(row).with_column(column)
  end
  
  def update_guess_board(guess_response)
    guess_board.update_data(guess_response)
    user_interface.record_result_of_guess(guess_response)
  end
  
  def coordinate
    @coordinate_builder
  end

end
