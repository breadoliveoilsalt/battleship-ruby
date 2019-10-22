class Ship

  attr_reader :type, :segments

  def initialize
    @type = nil
    @segments = [ ]
  end

  def set_type(ship_type)
    @type = ship_type
    self
  end
  
  def set_segments(segments)
    @segments = segments
    self
  end

  def sunk?
    segments.all? { |segment| segment.hit? }
  end

end
