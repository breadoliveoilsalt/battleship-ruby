class GuessBoard

  attr_reader :data
  
  def initialize
    @data = 
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

  def update_with(coordinate_guess, response)
    row = coordinate_guess.row.to_sym
    column = coordinate_guess.column.to_i - 1
    @data[row][column] = response.hit?
  end

end
