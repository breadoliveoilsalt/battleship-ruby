class FakeUserInterface

  attr_reader :calls

  def initialize()
    @calls = []
  end

  def clear_view
    @calls << :clear_view
  end

  def show_game(guess_board, fleet_board)
    @calls << :show_game
  end

  def show_fleet_board(board)
    @calls << :show_fleet_board
  end

  def show_guess_board(board)
    @calls << :show_guess_board
  end

  def get_row
    @calls << :get_row
    "a"
  end

  def get_column
    @calls << :get_column
    "1"
  end

  def record_response(coordinate_guess, response)
    @calls << :record_response
  end

  def record_result_of_guess(coordinate_guess, guess_response)
    @calls << :record_result_of_guess
  end

end

