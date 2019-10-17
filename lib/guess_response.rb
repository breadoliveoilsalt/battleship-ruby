class GuessResponse

  attr_reader :boat_type, :coordinate

  def initialize(bool = false)
    @hit = bool 
    @boat_sunk = false
    @boat_type = nil
    @coordinate = nil
  end

  def self.respond_with_miss
    GuessResponse.new(false)
  end

  def self.respond_with_hit
    GuessResponse.new(true)
  end

  def add_boat_sunk
    @boat_sunk = true
    self
  end

  def add_boat_type(boat_name)
    @boat_type = boat_name
    self
  end
  
  def add_coordinate(coordinate)
    @coordinate = coordinate
    self
  end

  def hit?
    @hit
  end

  def boat_sunk?
    @boat_sunk
  end

end
