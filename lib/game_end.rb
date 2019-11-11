class GameEnd

  def self.handle_game_over(user_interface, winner)
    user_interface.announce_winner(winner)
    user_interface.get_play_again
  end 

end
