class BoatSegment

  attr_reader :boat, :coordinate

  def initialize
    @boat = nil
    @coordinate = nil
    @hit = false
  end

  def set_boat(boat)
    @boat = boat
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
