require 'require_all'
require_all 'lib'

class Game

  attr_reader :user_interface

  def initialize
    @user_interface = ConsoleUserInterface.new(
      output_stream: ConsoleOutputStream.new,
      input_stream: ConsoleInputStream.new
    )
  end

  def start
    user_interface.show_welcome

    continue_playing = true

    while continue_playing
      human_player, computer_player = PlayerBuilder.new(user_interface).build_players_with_boards_and_ships
      winner = GameLoop.new(human_player, computer_player).loop_through_game      
      continue_playing = GameEnd.new(user_interface).handle_game_over(winner)
    end

    user_interface.good_bye
  end

end
