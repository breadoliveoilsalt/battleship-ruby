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
    FleetPlacementBoard.new(ships: [ship1, ship2])
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
    coordinate_2.column == next_column[coordinate_1.column.to_sym]
  end

  def are_horizontal?(coordinate_1, coordinate_2)
    coordinate_1.column == coordinate_2.column
  end

  def adjacent_row?(coordinate_1, coordinate_2)
    coordinate_2.row == next_row[coordinate_1.row.to_sym]
  end

  def next_row
    { a: "b",
      b: "c",
      c: "d",
      d: "e",
      e: "f",
      f: "g",
      g: "h",
      h: "i",
      i: "j",
      j: nil
    }
  end    

  def next_column
    { "1": "2",
      "2": "3",
      "3": "4",
      "4": "5",
      "5": "6",
      "6": "7",
      "7": "8",
      "8": "9",
      "9": "10",
      "10": nil
    }
  end

end
