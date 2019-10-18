require_relative '../lib/board.rb'
require_relative '../lib/boat.rb'

describe Board do

  let(:board) { Board.new }

  describe "#boats" do

    it "defaults to an empty array" do
      expect(board.boats).to eq([ ])
    end

  end

  describe "#set_boats" do

    it "sets the return value of #boats with the argument passed in" do
      boats = [double("Boat 1"), double("Boat 2")]

      board.set_boats(boats)

      expect(board.boats).to eq(boats)
    end

    it "returns self" do
      boats = [double("Boat 1"), double("Boat 2")]

      result = board.set_boats(boats)

      expect(result).to eq(boats)
    end

  end

  describe "#all_boats_sunk?" do 
    
    it "returns true when all boats respond to #sunk? with true" do 
      boat1 = instance_double("Boat", :sunk? => true)
      boat2 = instance_double("Boat", :sunk? => true)
      board.set_boats([boat1, boat2])

      result = board.all_boats_sunk?

      expect(result).to eq(true)
    end
    
    it "returns false when one boat respond to #sunk? with false" do 
      boat1 = instance_double("Boat", :sunk? => true)
      boat2 = instance_double("Boat", :sunk? => false)
      board.set_boats([boat1, boat2])

      result = board.all_boats_sunk?

      expect(result).to eq(false)
    end

  end

  describe "#data" do

    it "defaults to a hash with keys for the letters 'a' through 'j', each with a value of an empty array" do 
      expected_result = {
        a: [ ],
        b: [ ],
        c: [ ],
        d: [ ],
        e: [ ],
        f: [ ],
        g: [ ],
        h: [ ],
        i: [ ],
        j: [ ]
      }
      
      expect(board.data).to eq(expected_result)
    end

  end
end
