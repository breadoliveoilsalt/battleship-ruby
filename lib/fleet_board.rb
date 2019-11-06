class FleetBoard

  attr_reader :ships, :data, :unsunk_ships, :sunk_ships

  def initialize(ships:)
    @ships = ships 
    @data = {
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
    @unsunk_ships = ["Carrier", "Battleship", "Destroyer", "Submarine", "Patrol Boat"]
    @sunk_ships = [ ]
  end

  def set_ships(ships)
    @ships = ships
  end

  def all_ships_sunk?
    ships.all? { | ship | ship.sunk? }
  end

  def find_ship(coordinate_guess)
    ships.each do | ship |
      if ship.has_coordinate?(coordinate_guess)
        return ship
      end
    end
    nil
  end

  def update_data_with_guess(coordinate_guess)
    row = coordinate_guess.row.to_sym
    column = coordinate_guess.column.to_i - 1
    occupant = @data[row][column] 
    if !occupant
      @data[row][column] = false
    else
      occupant.mark_as_hit
      if occupant.ship.sunk?
        sunk_ships.push(occupant.ship.type)
        unsunk_ships.delete(occupant.ship.type)
      end
    end 
  end
  
  def update_data_with_ships
    ships.each do | ship |
      ship.segments.each do | segment |
        row = segment.coordinate.row.to_sym
        column = segment.coordinate.column.to_i - 1
        @data[row][column] = segment
      end
    end
  end

end
