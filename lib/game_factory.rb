require 'require_all'
require_all 'lib'

class GameFactory

  attr_reader :user_interface
  
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def build_players_with_boards_and_ships
    [build_human_player, build_computer_player]
  end
  
  def build_human_player
    guess_board = GuessBoard.new

    fleet_board = FleetBoardBuilderForUser.new(
      user_interface: user_interface,
      board_builder: FleetBoardBuilderWithRandomPlacement
    ).cycle_through_boards

    human_player = HumanPlayer.new(
      user_interface: user_interface, 
      guess_board: guess_board,
      fleet_board: fleet_board
    )

    human_player
  end

  def build_computer_player
    fleet_board = FleetBoardBuilderWithRandomPlacement.build
    
    computer_player = ComputerPlayer.new(
      ai: AI.new,
      fleet_board: fleet_board
    )

    computer_player
  end

  def place_ships_for_computer_player
    ships = ShipBuilder.new.build_ships_with_segments
    fleet_board = FleetPlacementBoard.new(ships: ships)
    AI.new.pick_coordinates_for_ships(fleet_board)
    fleet_board.update_data_with_ships
    fleet_board
  end

  def place_ships_for_human_player
    accept_board = false
    while !accept_board
      ships = ShipBuilder.new.build_ships_with_segments
      fleet_board = FleetPlacementBoard.new(ships: ships)
      AI.new.pick_coordinates_for_ships(fleet_board)
      fleet_board.update_data_with_ships
      user_interface.show_potential_fleet_board(fleet_board)
      accept_board = user_interface.get_board_ok
    end
    fleet_board
  end

end
