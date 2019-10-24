require_relative './ship.rb'
require_relative './ship_segment.rb'

class ShipBuilder

  def build_ships_with_segments
    ships = [ ]
    ships << build_carrier
    ships << build_battleship
    ships << build_destroyer
    ships << build_submarine
    ships << build_patrol_boat
  end

  def build_carrier
    ship = Ship.new("Carrier")
    5.times do
      ship.segments << ShipSegment.new.set_ship(ship)
    end
    ship
  end

  def build_battleship
    ship = Ship.new("Battleship")
    4.times do
      ship.segments << ShipSegment.new.set_ship(ship)
    end
    ship
  end

  def build_destroyer
    ship = Ship.new("Destroyer")
    3.times do
      ship.segments << ShipSegment.new.set_ship(ship)
    end
    ship
  end

  def build_submarine
    ship = Ship.new("Submarine")
    3.times do
      ship.segments << ShipSegment.new.set_ship(ship)
    end
    ship
  end

  def build_patrol_boat
    ship = Ship.new("Patrol Boat")
    2.times do
      ship.segments << ShipSegment.new.set_ship(ship)
    end
    ship
  end

end
