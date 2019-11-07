class GuessBoard

  attr_reader :board, :unsunk_ships, :sunk_ships
  
  def initialize
    @data = Array.new(10, Array.new(10,nil))
    @unsunk_ships = ["Carrier", "Battleship", "Destroyer", "Submarine", "Patrol Boat"]
    @sunk_ships = [ ]
  end

  def update_with(coordinate_guess, response)
    set_data(coordinate_guess.row, coordinate_guess.column, response.hit?)
    update_ships_list(response)
  end

  def update_ships_list(response)
    if response.ship_sunk?
      sunk_ships.push(response.ship_type)
      unsunk_ships.delete(response.ship_type)
    end
  end

  def get_empty_coordinate
    random_row = rand(0...data.length) 
    random_column = rand(0...data.length)
    occupant = get(random_row, random_column)
    if occupant == nil
      return Coordinate.new(random_row, random_column)
    else
      get_empty_coordinate
    end
  end

  def set_data(row, column, value)
    @data[row][column] = value
  end

end
