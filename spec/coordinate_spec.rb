require_relative '../lib/coordinate.rb'

describe Coordinate do

  let(:coordinate) { Coordinate.new }

  describe "#row" do

    it "exists with a default of nil" do
      expect(coordinate.row).to be(nil)
    end

  end

  describe "#with_row" do  
    
    it "sets the return value of #row" do
      coordinate.with_row("a")

      result = coordinate.row

      expect(result).to eq("a")
    end

    it "returns self" do
      coordinate.with_row("a")
      
      result = coordinate

      expect(result).to eq(coordinate)
    end

  end

  describe "#column" do

    it "exists with a default of nil" do
      expect(coordinate.column).to be(nil)
    end

  end

  describe "#with_column" do  
    
    it "sets @column" do
      coordinate.with_column("1")

      result = coordinate.column

      expect(result).to eq("1")
    end

    it "returns self" do
      coordinate.with_column("1")

      result = coordinate

      expect(result).to eq(coordinate)
    end

  end
end
