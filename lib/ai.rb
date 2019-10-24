require 'require_all'
require_all 'lib'

class AI

  def assign_coordinates_to_ships(fleet_placement_board)
      ## carrier
    fleet_placement_board.ships[0].segments[0].set_coordinate(Coordinate.new("a","1"))
    fleet_placement_board.ships[0].segments[1].set_coordinate(Coordinate.new("a","2"))
    fleet_placement_board.ships[0].segments[2].set_coordinate(Coordinate.new("a","3"))
    fleet_placement_board.ships[0].segments[3].set_coordinate(Coordinate.new("a","4"))
    fleet_placement_board.ships[0].segments[4].set_coordinate(Coordinate.new("a","5"))

      # battleship
    fleet_placement_board.ships[1].segments[0].set_coordinate(Coordinate.new("b","1"))
    fleet_placement_board.ships[1].segments[1].set_coordinate(Coordinate.new("b","2"))
    fleet_placement_board.ships[1].segments[2].set_coordinate(Coordinate.new("b","3"))
    fleet_placement_board.ships[1].segments[3].set_coordinate(Coordinate.new("b","4"))

      # destroyer
    fleet_placement_board.ships[2].segments[0].set_coordinate(Coordinate.new("c","1"))
    fleet_placement_board.ships[2].segments[1].set_coordinate(Coordinate.new("c","2"))
    fleet_placement_board.ships[2].segments[2].set_coordinate(Coordinate.new("c","3"))

      # submarine
    fleet_placement_board.ships[3].segments[0].set_coordinate(Coordinate.new("d","1"))
    fleet_placement_board.ships[3].segments[1].set_coordinate(Coordinate.new("d","2"))
    fleet_placement_board.ships[3].segments[2].set_coordinate(Coordinate.new("d","3"))

      # patrol boat
    fleet_placement_board.ships[4].segments[0].set_coordinate(Coordinate.new("e","1"))
    fleet_placement_board.ships[4].segments[1].set_coordinate(Coordinate.new("e","2"))

    fleet_placement_board.update_data_with_ships
  end

  def assign_coordinates_to_ships_one_left(fleet_placement_board)
      ## carrier
    fleet_placement_board.ships[0].segments[0].set_coordinate(Coordinate.new("a","1")).mark_as_hit
    fleet_placement_board.ships[0].segments[1].set_coordinate(Coordinate.new("a","2")).mark_as_hit
    fleet_placement_board.ships[0].segments[2].set_coordinate(Coordinate.new("a","3")).mark_as_hit
    fleet_placement_board.ships[0].segments[3].set_coordinate(Coordinate.new("a","4")).mark_as_hit
    fleet_placement_board.ships[0].segments[4].set_coordinate(Coordinate.new("a","5")).mark_as_hit

      # battleship
    fleet_placement_board.ships[1].segments[0].set_coordinate(Coordinate.new("b","1")).mark_as_hit
    fleet_placement_board.ships[1].segments[1].set_coordinate(Coordinate.new("b","2")).mark_as_hit
    fleet_placement_board.ships[1].segments[2].set_coordinate(Coordinate.new("b","3")).mark_as_hit
    fleet_placement_board.ships[1].segments[3].set_coordinate(Coordinate.new("b","4")).mark_as_hit

      # destroyer
    fleet_placement_board.ships[2].segments[0].set_coordinate(Coordinate.new("c","1")).mark_as_hit
    fleet_placement_board.ships[2].segments[1].set_coordinate(Coordinate.new("c","2")).mark_as_hit
    fleet_placement_board.ships[2].segments[2].set_coordinate(Coordinate.new("c","3")).mark_as_hit

      # submarine
    fleet_placement_board.ships[3].segments[0].set_coordinate(Coordinate.new("d","1")).mark_as_hit
    fleet_placement_board.ships[3].segments[1].set_coordinate(Coordinate.new("d","2")).mark_as_hit
    fleet_placement_board.ships[3].segments[2].set_coordinate(Coordinate.new("d","3")).mark_as_hit

      # patrol boat
    fleet_placement_board.ships[4].segments[0].set_coordinate(Coordinate.new("e","1")).mark_as_hit
    fleet_placement_board.ships[4].segments[1].set_coordinate(Coordinate.new("e","2"))

    fleet_placement_board.update_data_with_ships
  end

end
