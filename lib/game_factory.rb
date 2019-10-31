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

    fleet_board = FleetBoardChooserForUser.new(
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
      fleet_board: fleet_board
    )

    computer_player
  end

end
