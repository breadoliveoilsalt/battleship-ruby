require 'require_all'
require_all 'lib'

describe AIForPlacingShips do

  let(:ai) { AIForPlacingShips.new }

  let(:fleet_board) { fpb_with_two_ships }
  
  describe "#pick_coordinates_for_ships" do

    it "assigns adjacent coordinates to ships either vertically or horizontally" do
      ai.pick_coordinates_for_ships(fleet_board)

      fleet_board.ships.each do | ship |
        coordinate_1, coordinate_2, coordinate_3 = get_coordinates(ship)

        if are_vertical?(coordinate_1, coordinate_2)
          expect(are_vertical?(coordinate_2, coordinate_3)).to be(true)
          expect(adjacent_column?(coordinate_1, coordinate_2)).to be(true)
          expect(adjacent_column?(coordinate_2, coordinate_3)).to be(true)
        elsif are_horizontal?(coordinate_1, coordinate_2)
          expect(are_horizontal?(coordinate_2, coordinate_3)).to be(true)
          expect(adjacent_row?(coordinate_1, coordinate_2)).to be(true)
          expect(adjacent_row?(coordinate_2, coordinate_3)).to be(true)
        else
          raise "Failure"
        end
      end
    end

  end

  def fpb_with_two_ships
    ship1 = Ship.new.set_segments([ShipSegment.new, ShipSegment.new, ShipSegment.new])
    ship2 = Ship.new.set_segments([ShipSegment.new, ShipSegment.new, ShipSegment.new])
    FleetBoard.new(ships: [ship1, ship2])
  end

  def get_coordinates(ship)
    [
      ship.segments[0].coordinate,
      ship.segments[1].coordinate,
      ship.segments[2].coordinate
    ]
  end

  def are_vertical?(coordinate_1, coordinate_2)
    coordinate_1.row == coordinate_2.row
  end

  def adjacent_column?(coordinate_1, coordinate_2)
    coordinate_2.column == coordinate_1.column + 1
  end

  def are_horizontal?(coordinate_1, coordinate_2)
    coordinate_1.column == coordinate_2.column
  end

  def adjacent_row?(coordinate_1, coordinate_2)
    coordinate_2.row == coordinate_1.row + 1
  end

end
