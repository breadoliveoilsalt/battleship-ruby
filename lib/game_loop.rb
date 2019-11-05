class GameLoop

  attr_reader :player_1, :player_2, :current_player, :other_player
  
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2 
    @current_player = player_1 
    @other_player = player_2
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
    !player_1.lost_game? && !player_2.lost_game?
  end

  def winner
    @other_player
  end

end
