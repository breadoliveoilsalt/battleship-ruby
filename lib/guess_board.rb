class GuessBoard

  attr_reader :data
  
  def initialize(board_data: )
    @data = board_data
  end

  def update_with(coordinate_guess, response)
    row = coordinate_guess.row.to_sym
    column = coordinate_guess.column.to_i - 1
    data.update_data(row, column, response.hit?)
  end

end
