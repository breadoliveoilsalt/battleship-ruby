class BoardData

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

  def update_data(row, column, hit)
    @data[row][column] = hit
  end

end
