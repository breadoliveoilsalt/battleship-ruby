require 'require_all'
require_all 'lib'

describe FleetBoardBuilderWithRandomPlacement do

  let(:fleet_board_builder) { FleetBoardBuilderWithRandomPlacement }

  describe "#build" do

    it "returns a FleetPlacementBoard instance" do
      fleet_board = fleet_board_builder.build

      expect(fleet_board).to be_a(FleetBoard)
    end

    describe "each returned FleetPlacementBoard instance" do

      it "has ships with coordinates assigned to each ship segment by the AI" do
        ships = fleet_board_builder.build.ships

        result = check_each_segment_has_a_coordinate(ships)

        expect(result).to be(true)
      end

      it "has data that marks where each ship segment is placed on the board" do
        fleet_board = fleet_board_builder.build

        result = check_data_matches_segment_coordinates(fleet_board)

        expect(result).to be(true)
      end

      it "has ships placed differently than other built FleetPlacementBoards" do
        fleet_board_1 = fleet_board_builder.build
        fleet_board_2 = fleet_board_builder.build
        fleet_board_3 = fleet_board_builder.build

        expect(fleet_board_1.data == fleet_board_2.data).to be(false)
        expect(fleet_board_1.data == fleet_board_3.data).to be(false)
        expect(fleet_board_2.data == fleet_board_3.data).to be(false)
      end

    end

  end

  def check_each_segment_has_a_coordinate(ships)
    ships.each do | ship |
      if ship.segments.any? { | segment| segment.coordinate == nil }
        return false
      end
    end
    true
  end
  
  def check_data_matches_segment_coordinates(fleet_board)
    fleet_board.ships.each do | ship |
      ship.segments.each do | segment |
        data_row = segment.coordinate.row
        data_column = segment.coordinate.column
        if fleet_board.data[data_row][data_column] != segment
          return false
        end
      end
    end
    true
  end

end
