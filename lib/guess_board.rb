class GuessBoard

  def initialize(data_representation: )
    @data_representation = data_representation
  end

  def update_with(coordinate_guess, response)
    @data_representation.update_data(coordinate_guess, response)
  end

  def data
    @data_representation.data
  end

end
