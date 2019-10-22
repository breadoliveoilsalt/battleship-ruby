require_relative '../lib/guess_response.rb'

describe GuessResponse do

  let(:guess_response) { GuessResponse.new }

  describe "#hit?" do

    it "defaults to false" do
      expect(guess_response.hit?).to be(false)
    end

  end
  
  describe "#ship_sunk?" do

    it "defaults to false" do
      expect(guess_response.ship_sunk?).to be(false)
    end

  end

  describe "#ship_type" do

    it "defaults to nil" do
      expect(guess_response.ship_type).to be(nil)
    end

  end

  describe "#coordinate" do

    it "defaults to nil" do
      expect(guess_response.coordinate).to be(nil)
    end

  end

  describe "#self.respond_with_miss" do
    
    it "returns a GuessResponse instance" do
      expect(GuessResponse.respond_with_miss).to be_a(GuessResponse)
    end

    describe "the instance returned by GuessResponse" do

      it "has a #hit? method that returns false" do
        expect(GuessResponse.respond_with_miss.hit?).to be(false)
      end

    end

  end

  describe "#self.respond_with_hit" do
    
    it "returns a GuessResponse instance" do
      expect(GuessResponse.respond_with_hit).to be_a(GuessResponse)
    end

    describe "the instance returned by GuessResponse" do

      it "has a #hit? method that returns true" do
        expect(GuessResponse.respond_with_hit.hit?).to be(true)
      end

    end

  end

  describe "#add_ship_sunk" do
    
    it "sets #ship_sunk? to true" do
      guess_response.add_ship_sunk
      
      expect(guess_response.ship_sunk?).to be(true)
    end

    it "returns self" do
      expect(guess_response.add_ship_sunk).to eq(guess_response)
    end

  end

  describe "#add_ship_type" do
    
    it "sets #ship_type to the argument passed in" do
      ship_type_arg = "Destroyer"  

      guess_response.add_ship_type(ship_type_arg)

      expect(guess_response.ship_type).to eq(ship_type_arg)
    end

    it "returns self" do
      ship_type_arg = "Destroyer"  

      response = guess_response.add_ship_type(ship_type_arg)

      expect(response).to eq(guess_response)
    end

  end

  describe "#add_coordinate" do
    
    it "sets #coordinate to the argument passed in" do
      coordinate_arg = double("Coordinate")  

      guess_response.add_coordinate(coordinate_arg)

      expect(guess_response.coordinate).to eq(coordinate_arg)
    end

    it "returns self" do
      coordinate_arg = double("Coordinate")  

      response = guess_response.add_coordinate(coordinate_arg)

      expect(response).to eq(guess_response)
    end

  end

end
