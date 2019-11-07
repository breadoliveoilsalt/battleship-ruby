class Board

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

  def get(row, col)
    @data[row][col]
  end

  def set(row, col, value)
    @data[row][col] = value
  end

  def set_data(data)
    @data = data
  end

end
