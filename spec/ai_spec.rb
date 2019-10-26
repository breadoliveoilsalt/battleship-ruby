require 'require_all'
require_all 'lib'

describe AI do

  let(:ai) { AI.new }

  describe "assign_coordinates_to_ships" do

    it "adds coordinates to the ships of a fleet_placement_board" do
      ships = ShipBuilder.new.build_ships_with_segments
      fleet_placement_board = FleetPlacementBoard.new(ships: ships)

      ai.assign_coordinates_to_ships(fleet_placement_board)
      
      fleet_placement_board.ships.each do | ship |
        ship.segments.each do | segment |
          expect(segment.coordinate).to be_a(Coordinate)
        end
      end
    end
  end

end
