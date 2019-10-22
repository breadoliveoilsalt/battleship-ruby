class ShipSegment

  attr_reader :ship, :board, :coordinate

  def initialize
    @ship = nil
    @board = nil
    @coordinate = nil
    @hit = false
  end

  def set_ship(ship)
    @ship = ship
    self
  end

  def set_board(board)
    @board = board
    self
  end

  def set_coordinate(coordinate)
    @coordinate = coordinate
    self
  end

  def hit?
    @hit
  end

  def mark_as_hit
    @hit = true
    self
  end

end
