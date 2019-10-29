require_relative './guess_response.rb'
require_relative './coordinate.rb'

class ComputerPlayer

  attr_reader :ai, :fleet_board

  def initialize(ai:, fleet_board:)
    @fleet_board = fleet_board
    @ai = ai
  end

  def place_ships
    ai.pick_coordinates_for_ships(fleet_board)
  end

  def respond_to_guess(coordinate_guess)
    fleet_board.update_data_with_guess(coordinate_guess)
    occupying_ship = fleet_board.find_ship(coordinate_guess)
    if !occupying_ship
      GuessResponse.respond_with_miss
    elsif occupying_ship.sunk?
      GuessResponse.respond_with_hit.add_ship_sunk(occupying_ship.type)
    else
      GuessResponse.respond_with_hit
    end
  end

  def lost_game?
    fleet_board.all_ships_sunk?
  end

end
