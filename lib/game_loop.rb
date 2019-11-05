class GameLoop

  attr_reader :human_player, :computer_player, :current_player, :other_player
  
  def initialize(human_player, computer_player)
    @human_player = human_player
    @computer_player = computer_player 
    @current_player = human_player 
    @other_player = computer_player
  end

  def loop_through_game
    begin
      guess_coordinate = current_player.make_guess
      response = other_player.respond_to_guess(guess_coordinate)
      current_player.note_response(guess_coordinate, response)
      switch_players
    end while game_not_over
    winner
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def game_not_over
    !human_player.lost_game? && !computer_player.lost_game?
  end

  def winner
    @other_player
  end

end
