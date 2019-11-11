require 'require_all'
require_all 'lib'

class HumanVsComputerPlayerBuilder

  def self.build_players_with_boards_and_ships(user_interface)
    set_user_interface(user_interface)
    [build_human_player, build_computer_player]
  end
  
  def self.build_human_player
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

  def self.build_computer_player
    fleet_board = FleetBoardBuilderWithRandomPlacement.build
    guess_board = GuessBoard.new
    
    computer_player = ComputerPlayer.new(
      fleet_board: fleet_board,
      guess_board: guess_board
    )

    computer_player
  end

  def self.user_interface
    @@user_interface
  end

  def self.set_user_interface(user_interface)
    @@user_interface = user_interface
  end  

end
