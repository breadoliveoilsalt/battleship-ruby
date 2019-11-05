class GuessBoard

  attr_reader :data, :unsunk_ships, :sunk_ships
  
  def initialize
    @data = 
      { 
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

  def update_with(coordinate_guess, response)
    row = coordinate_guess.row.to_sym
    column = coordinate_guess.column.to_i - 1
    @data[row][column] = response.hit?
    if response.ship_sunk?
      sunk_ships.push(response.ship_type)
      unsunk_ships.delete(response.ship_type)
    end
  end

  def get_empty_coordinate
    random_row = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].sample
    random_column = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].sample
    if @data[random_row.to_sym][random_column] == nil
      return Coordinate.new(random_row, (random_column + 1).to_s)
    else
      get_empty_coordinate
    end
  end

  def set_data(data)
    @data = data
  end

end
