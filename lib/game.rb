require 'require_all'
require_all 'lib'

class Game

  attr_reader :user_interface, :player_builder, :game_loop, :game_end

  def initialize(
    user_interface: ConsoleUserInterfaceBuilder.build,
    player_builder: HumanVsComputerPlayerBuilder,
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
    game_set_up_loop
    user_interface.good_bye
  end

  def game_set_up_loop
    begin
      player_1, player_2 = player_builder.build_players_with_boards_and_ships(user_interface)
      winner = game_loop.loop_through_game(player_1, player_2)
      continue_playing = game_end.handle_game_over(user_interface, winner)
    end while continue_playing
  end

end
