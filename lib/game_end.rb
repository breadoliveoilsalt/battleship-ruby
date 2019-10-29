require_relative '../lib/console_user_interface.rb'
require_relative '../lib/console_input_stream.rb'
require_relative '../lib/console_output_stream.rb'

class GameEnd

  attr_reader :user_interface

  def initialize(user_interface:)
    @user_interface = user_interface
  end

  def handle_game_over(winner)
    user_interface.announce_winner(winner)
    user_interface.get_play_again
  end 

end
