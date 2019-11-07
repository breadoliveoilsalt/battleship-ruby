require 'require_all'
require_all 'lib'

class AIForPlacingShips

  attr_accessor :coordinates_used

  def initialize
    @coordinates_used = [ ]
  end

  def pick_coordinates_for_ships(fleet_board)
    @fleet_board = fleet_board
    fleet_board.ships.each do |ship|
      place_ship(ship)
    end
  end

  def place_ship(ship)
    orientation = ["vertical", "horizontal"].sample
    random_row = get_possible_row(ship, orientation)
    random_column = get_possible_column(ship, orientation)
    starting_coordinate = [random_row, random_column]
    check_if_valid_placement(starting_coordinate, ship, orientation)
  end
 
  def get_possible_row(ship, orientation)
    orientation == "horizontal" ? rand(0...board_length) : rand(0...(board_length - ship.length))
  end

  def get_possible_column(ship, orientation)
    orientation == "vertical" ? rand(0...board_length) : rand(0...(board_length - ship.length))
  end

  def board_length
    @fleet_board.data.length
  end
  
  def check_if_valid_placement(starting_coordinate, ship, orientation)
    resulting_coordinates = generate_test_coordinates(starting_coordinate, ship, orientation)
    resulting_coordinates.each do | coordinate |
      if coordinates_used.include?(coordinate)
        return place_ship(ship)
      end
    end
    @coordinates_used = coordinates_used.concat(resulting_coordinates)
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
      row = resulting_coordinates[index][0]
      column = resulting_coordinates[index][1]
      segment.set_coordinate(Coordinate.new(row, column))
    end
  end
    
end
