class BoardData

  attr_reader :data

  def initialize
    @data = default_data
  end

  def default_data
    { 
      a: Array.new(10, nil),
      b: Array.new(10, nil),
      c: Array.new(10, nil),
      d: Array.new(10, nil),
      e: Array.new(10, nil),
      f: Array.new(10, nil),
      g: Array.new(10, nil),
      h: Array.new(10, nil),
      i: Array.new(10, nil),
      j: Array.new(10, nil)
    }
  end

  def update_data(coordinate_guess, response)
    data_row = coordinate_guess.row.to_sym
    data_column = coordinate_guess.column.to_i - 1
    if response.hit?
      @data[data_row][data_column] = true 
    elsif !response.hit?
      @data[data_row][data_column] = false 
    end
  end

end

