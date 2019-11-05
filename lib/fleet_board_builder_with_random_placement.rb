require 'require_all'
require_all 'lib'

class FleetBoardBuilderWithRandomPlacement

  def self.build
    ships = ShipBuilder.new.build_ships_with_segments
    fleet_board = FleetBoard.new(ships: ships)
    AIForPlacingShips.new.pick_coordinates_for_ships(fleet_board)
    fleet_board.update_data_with_ships
    fleet_board
  end

end
