require 'require_all'
require_all 'lib'

class Game

  def start
    continue_playing = true

    while continue_playing
      human_player, computer_player = GameFactory.new.build_players_with_boards_and_ships
      winner = GameLoop.new(human_player, computer_player).loop_through_game      
      continue_playing = GameEnd.new.handle_game_over(winner)
    end
  end

end
