class Board

  attr_reader :boats

  def initialize
    @boats = [ ]
  end

  def set_boats(boats)
    @boats = boats
  end

  def all_boats_sunk?
    boats.all? { | boat | boat.sunk? }
  end

  def data
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

end
