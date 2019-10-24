require 'require_all'
require_all 'lib'

class GameFactory

  def build_players_with_boards_and_ships
    [build_human_player, build_computer_player]
  end
  
  def build_human_player
    guess_board = GuessBoard.new

    player_1 = HumanPlayer.new(
      user_interface: console_user_interface, 
      guess_board: guess_board)
    
    player_1
  end

  def console_user_interface
    ConsoleUserInterface.new(
      output_stream: ConsoleOutputStream.new,
      input_stream: ConsoleInputStream.new
    )
  end
            
  def build_computer_player
    ships = ShipBuilder.new.build_ships_with_segments
    fleet_placement_board = FleetPlacementBoard.new(ships: ships)
    computer_player = ComputerPlayer.new(
      ai: AI.new,
      fleet_placement_board: fleet_placement_board)
    computer_player.place_ships
    computer_player
  end

end
