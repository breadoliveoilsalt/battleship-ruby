require_relative './coordinate.rb'

class AICoordinates

  def pick_coordinates_for_ships(fleet_placement_board)
    coordinates_already_used = []
    fleet_placement_board.ships.each do |ship|
      place_ship(ship, coordinates_already_used)
    end
    fleet_placement_board.update_data_with_ships
  end

  def place_ship(ship, coordinates_already_used)
    orientation = ["vertical", "horizontal"].sample
    random_row = possible_rows(ship, orientation).sample
    random_column = possible_columns(ship, orientation).sample
    starting_coordinate = [random_row, random_column]
    check_if_valid_placement(starting_coordinate, ship, orientation, coordinates_already_used)
  end
 
  def possible_rows(ship, orientation)
    orientation == "horizontal" ? rows_data[0..9] : rows_data[0..(10-ship.length)]
  end

  def possible_columns(ship, orientation)
    orientation == "vertical" ? columns_data[0..9] : columns_data[0..(10-ship.length)]
  end

  def rows_data
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def columns_data
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def check_if_valid_placement(starting_coordinate, ship, orientation, coordinates_already_used)
    resulting_coordinates = generate_test_coordinates(starting_coordinate, ship, orientation)
    resulting_coordinates.each do | coordinate |
      if coordinates_already_used.include?(coordinate)
        return place_ship(ship, coordinates_already_used)
      end
    end
    coordinates_already_used = coordinates_already_used.concat(resulting_coordinates)
    assign_resulting_coordinates(ship, resulting_coordinates)
  end

  def generate_test_coordinates(starting_coordinate, ship, orientation)
    test_coordinates = []
    row = starting_coordinate[0]
    column = starting_coordinate[1]
    ship.length.times do 
      test_coordinates.push([row, column])
      orientation == "vertical" ? row += 1 : column += 1
    end
    test_coordinates
  end

  def assign_resulting_coordinates(ship, resulting_coordinates)
    ship.segments.each_with_index do | segment, index |
      data_row = resulting_coordinates[index][0]
      row_string = convert_row[data_row]
      data_column = resulting_coordinates[index][1]
      column_string = convert_column[data_column]
      segment.set_coordinate(Coordinate.new(row_string, column_string))
    end
  end
    
  def convert_row
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
  end

  def convert_column
    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  end  

end
