require_relative '../lib/board_data.rb'
require_relative '../lib/guess_response.rb'
require_relative '../lib/coordinate.rb'

describe BoardData do

  let(:board_data) { BoardData.new }

  describe "#new" do

    it "sets @data to a hash with keys 'a' through 'j', each with a value of an array filled with 10 nils" do
      expected_data = {
        a: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        b: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        c: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        d: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        e: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        f: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        g: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        h: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        i: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        j: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
      }

      data = board_data.instance_variable_get(:@data)
      
      expect(data).to eq(expected_data)
    end

  end
  
  describe "#data" do

    it "gets @data" do
      expected_data = board_data.instance_variable_get(:@data)

      expect(board_data.data).to eq(expected_data) 
    end

  end

  describe "#update_data" do

    it "updates an array element in @data corresponding to the arguments row and column with the status of the argument hit" do
      row = :a
      column = 0
      hit = true

      board_data.update_data(row, column, hit)

      data_grid_coordinate = board_data.data[:a][0]
      expect(data_grid_coordinate).to eq(true)
    end

  end

end
