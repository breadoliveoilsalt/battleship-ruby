class GuessBoard

  def initialize(data_representation: )
    @data_representation = data_representation
  end

  def update_with(coordinate_guess, response)
    row = coordinate_guess.row.to_sym
    column = coordinate_guess.column.to_i
    @data_representation.update_data(row, column, response.hit?)
  end

  def data
    @data_representation.data
  end

end
