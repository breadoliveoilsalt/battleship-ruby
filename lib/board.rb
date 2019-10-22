class Board

  attr_reader :ships

  def initialize
    @ships = [ ]
  end

  def set_ships(ships)
    @ships = ships
  end

  def all_ships_sunk?
    ships.all? { | ship | ship.sunk? }
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
