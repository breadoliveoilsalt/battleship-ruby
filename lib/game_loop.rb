class GameLoop

  attr_reader :human_player, :computer_player
  
  def initialize(human_player, computer_player)
    @human_player = human_player
    @computer_player = computer_player 
    @current_player = human_player 
  end
  
  def loop_through_game
    while !current_player_won_game?
      guess_coordinate = current_player.make_guess
      response = other_player.respond_to_guess(guess_coordinate)
      current_player.note_response(guess_coordinate, response)
    end
    current_player
   end

  def current_player_won_game?
    other_player.lost_game?
  end

  def current_player
    human_player
  end

  def other_player
    computer_player  
  end

end
