require_relative './guess_response.rb'
require_relative './coordinate.rb'

class ComputerPlayer

  attr_reader :ships, :fleet_placement_board, :ai

  def initialize(ships:, fleet_placement_board:, ai:)
    @ships = ships
    @fleet_placement_board = fleet_placement_board
    @ai = ai
  end

  def place_ships
    ai.assign_coordinates_to_ship_segments(ships) 
      # or does CP tell fleet placement to do this and pass ai? Does cp
      # really need to know about its ships if it's asking FPB to do everything else?
    fleet_placement_board.update_with_ships(ships)
  end

  def respond_to_guess(coordinate_guess)
    occupying_ship = fleet_placement_board.find_and_update(coordinate_guess)
    if !occupying_ship
      GuessResponse.respond_with_miss
    else 
      if occupying_ship.sunk?
        GuessResponse.respond_with_hit.add_ship_sunk(occupying_ship.type)
      else
        GuessResponse.respond_with_hit
      end
    end
  end

  def lost_game?
    fleet_placement_board.all_ships_sunk?
  end

end
