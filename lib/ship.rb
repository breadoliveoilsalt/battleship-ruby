class Ship

  attr_reader :type, :segments

  def initialize(type = "Ship")
    @type = type
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

  def has_coordinate?(coordinate)
    segments.any? { |segment| segment.coordinate == coordinate }
  end

  def length
    segments.length
  end

end
