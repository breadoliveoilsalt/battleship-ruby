require 'require_all'
require_all 'lib'

describe FleetBoardBuilderForUser do

  let(:user_interface) { instance_double("UserInterface") }
  let(:board_builder) { class_double("FleetBoardBuilderWithRandomPlacement") }

  describe "#cycle_through_boards" do
    
    it "returns a fleet board built with 'board_builder' passed in at instantiation" do
      fleet_board_builder_for_user = FleetBoardBuilderForUser.new(
        user_interface: user_interface,
        board_builder: FleetBoardBuilderWithRandomPlacement
      )
      allow(user_interface).to receive(:show_potential_fleet_board)
      allow(user_interface).to receive(:get_board_ok).and_return(true)

      result = fleet_board_builder_for_user.cycle_through_boards
      
      expect(result).to be_a(FleetBoard)
    end

  describe "the method's cycle" do

    let(:fleet_board_builder_for_user) { FleetBoardBuilderForUser.new(
      user_interface: user_interface,
      board_builder: board_builder 
    ) }

    let(:board_1) { instance_double("FleetBoard", "board 1") }
    let(:board_2) { instance_double("FleetBoard", "board 2") }
    let(:board_3) { instance_double("FleetBoard", "board 3") }

    before(:each) do
      allow(board_builder).to receive(:build).and_return(board_1, board_2, board_3)
    end

    it "shows the user new fleet boards until the user selects one" do

      allow(user_interface).to receive(:get_board_ok).and_return(false, false, true)
      
      expect(user_interface).to receive(:show_potential_fleet_board).with(board_1).once
      expect(user_interface).to receive(:show_potential_fleet_board).with(board_2).once
      expect(user_interface).to receive(:show_potential_fleet_board).with(board_3).once

      fleet_board_builder_for_user.cycle_through_boards
    end

    it "returns the fleet board chosen by the user" do

      allow(user_interface).to receive(:show_potential_fleet_board)
      allow(user_interface).to receive(:get_board_ok).and_return(false, false, true)
      
      result = fleet_board_builder_for_user.cycle_through_boards
      expect(result).to eq(board_3)
    end
    end
  end
end
