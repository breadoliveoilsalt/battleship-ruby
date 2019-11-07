class FleetBoard

  attr_reader :ships, :data, :unsunk_ships, :sunk_ships

  def initialize(ships:)
    @ships = ships 
    @data = [
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    ]
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

  def update_with(coordinate_guess)
    row = coordinate_guess.row
    column = coordinate_guess.column
    occupant = get(row, column)
    if !occupant
      set(row, column, false)
    else
      occupant.mark_as_hit
      update_ships_list(occupant)
    end 
  end
  
  def update_ships_list(occupant)
    if occupant.ship_sunk?
      sunk_ships.push(occupant.ship_type)
      unsunk_ships.delete(occupant.ship_type)
    end
  end

  def update_data_with_ships
    ships.each do | ship |
      ship.segments.each do | segment |
        row = segment.coordinate.row
        column = segment.coordinate.column
        set(row, column, segment)
      end
    end
  end

  def get(row, column)
    @data[row][column]
  end

  def set(row, column, value)
    @data[row][column] = value
  end

end
