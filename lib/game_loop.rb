class GameLoop

  def self.loop_through_game(player_1, player_2)
    @@player_1 = player_1
    @@player_2 = player_2 
    @@current_player = player_1 
    @@other_player = player_2
    enter_loop
    winner
  end

  def self.enter_loop
    begin
      guess_coordinate = current_player.make_guess
      response = other_player.respond_to_guess(guess_coordinate)
      current_player.note_response(guess_coordinate, response)
      switch_players
    end while game_not_over
  end
  
  def self.switch_players
    @@current_player, @@other_player = @@other_player, @@current_player
  end

  def self.game_not_over
    !@@player_1.lost_game? && !@@player_2.lost_game?
  end

  def self.current_player
    @@current_player
  end

  def self.other_player
    @@other_player
  end

  def self.winner
    @@other_player
  end

end
