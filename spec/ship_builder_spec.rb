require_relative '../lib/ship_builder.rb'

describe ShipBuilder do

  describe "#build_ships_with_segments" do

    let(:ships) { ShipBuilder.new.build_ships_with_segments }

    it "returns an array with five Ship objects" do
      all_are_ships = ships.all? { |ship| ship.is_a?(Ship) }
      expect(all_are_ships).to be(true)
      expect(ships.length).to eq(5)
    end

    describe "the first ship object" do

      it "has a #type 'Carrier' with 5 Segments" do
        ship = ships[0]
        expect(ship.type).to eq("Carrier")
        expect(ship.segments.length).to eq(5)
        
        all_are_segments = ship.segments.all? { |segment| segment.is_a?(ShipSegment) }
        expect(all_are_segments).to be(true)
      end

    end

    describe "the second ship object" do

      it "has a #type 'Battleship' with 4 Segments" do
        ship = ships[1]
        expect(ship.type).to eq("Battleship")
        expect(ship.segments.length).to eq(4)
        
        all_are_segments = ship.segments.all? { |segment| segment.is_a?(ShipSegment) }
        expect(all_are_segments).to be(true)
      end

    end

    describe "the third ship object" do

      it "has a #type 'Destroyer' with 3 Segments" do
        ship = ships[2]
        expect(ship.type).to eq("Destroyer")
        expect(ship.segments.length).to eq(3)
        
        all_are_segments = ship.segments.all? { |segment| segment.is_a?(ShipSegment) }
        expect(all_are_segments).to be(true)
      end

    end

    describe "the fourth ship object" do

      it "has a #type 'Submarine' with 3 Segments" do
        ship = ships[3]
        expect(ship.type).to eq("Submarine")
        expect(ship.segments.length).to eq(3)
        
        all_are_segments = ship.segments.all? { |segment| segment.is_a?(ShipSegment) }
        expect(all_are_segments).to be(true)
      end

    end

    describe "the fifth ship object" do

      it "has a #type 'Patrol Boat' with 2 Segments" do
        ship = ships[4]
        expect(ship.type).to eq("Patrol Boat")
        expect(ship.segments.length).to eq(2)
        
        all_are_segments = ship.segments.all? { |segment| segment.is_a?(ShipSegment) }
        expect(all_are_segments).to be(true)
      end

    end

  end

end
