require_relative './guess_response.rb'
require_relative './coordinate.rb'

class ComputerPlayer

  attr_accessor :ships, :fleet_placement_board

  def initialize(:ships, :fleet_placement_board)
    @ships = ships
    @fleet_placement_board = nil
  end

  def place_ships
    ai.assign_coordinates_to_ship_segments(ships)
    fleet_placement_board.update_ships(ships)
  end

  def respond_to_guess(coordinate_guess)
    occupying_boat = fleet_placement_board.find_and_update(coordinate_guess)
    if !occupying_boat
      GuessResponse.respond_with_miss
    else 
      if occupying_boat.sunk?
        GuessResponse.respond_with_hit.add_sunk(occupying_boat.type)
      else
        GuessResponse.respond_with_hit
      end
    end
  end

  def lost_game?
    fleet_placement_board.all_ships_sunk?
  end

end
