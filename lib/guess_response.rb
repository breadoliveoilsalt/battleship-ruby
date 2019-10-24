class GuessResponse

  attr_reader :ship_type, :coordinate

  def initialize(bool = false)
    @hit = bool 
    @ship_sunk = false
    @ship_type = nil
    @coordinate = nil
  end

  def self.respond_with_miss
    GuessResponse.new(false)
  end

  def self.respond_with_hit
    GuessResponse.new(true)
  end

  def add_ship_sunk(ship_type)
    @ship_sunk = true
    @ship_type = ship_type
    self
  end

  def add_ship_type(ship_type)
    @ship_type = ship_type
    self
  end
  
  def add_coordinate(coordinate)
    @coordinate = coordinate
    self
  end

  def hit?
    @hit
  end

  def ship_sunk?
    @ship_sunk
  end

end
