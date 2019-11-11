require 'require_all'
require_all 'lib'

class Game

  attr_reader :user_interface

  def initialize(
    user_interface: ConsoleUserInterfaceBuilder.build,
    player_builder: PlayerBuilder,
    game_loop: GameLoop,
    game_end: GameEnd
    )

    @user_interface = user_interface
    @player_builder = player_builder
    @game_loop = game_loop
    @game_end = game_end
  end

  def start
    user_interface.show_welcome

    continue_playing = true

    while continue_playing
      player_1, player_2 = @player_builder.new(user_interface).build_players_with_boards_and_ships
      winner = @game_loop.new(player_1, player_2).loop_through_game      
      continue_playing = @game_end.new(user_interface).handle_game_over(winner)
    end

    user_interface.good_bye
  end

end
