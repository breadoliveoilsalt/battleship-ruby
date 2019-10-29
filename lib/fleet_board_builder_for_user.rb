class FleetBoardBuilderForUser

  attr_reader :user_interface, :board_builder

  def initialize(user_interface:, board_builder:)
    @user_interface = user_interface
    @board_builder = board_builder
  end

  def cycle_through_boards
    begin 
      fleet_board = board_builder.build
      user_interface.show_potential_fleet_board(fleet_board)
      user_accepts_board = user_interface.get_board_ok
    end while !user_accepts_board
    fleet_board
  end

end
