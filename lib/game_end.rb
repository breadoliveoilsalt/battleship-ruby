require_relative '../lib/console_user_interface.rb'
require_relative '../lib/console_input_stream.rb'
require_relative '../lib/console_output_stream.rb'

class GameEnd

  def handle_game_over(winner)
    user_interface.good_bye
  end 

    # To clean up
  def user_interface
    ConsoleUserInterface.new(
      output_stream: ConsoleOutputStream.new,
      input_stream: ConsoleInputStream.new
    ) 
  end 

end
