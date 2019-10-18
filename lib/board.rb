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

end
