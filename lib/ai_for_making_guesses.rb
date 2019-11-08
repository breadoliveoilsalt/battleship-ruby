require_relative '../lib/coordinate.rb'

class AIForMakingGuesses

  attr_reader :guess_board

  def make_guess(guess_board)
    @guess_board = guess_board
    follow_up = follow_up_on_hits
    if follow_up
      follow_up
    else
      get_empty_coordinate
    end
  end

  def get_empty_coordinate
    random_row = rand(0...data.length) 
    random_column = rand(0...data.length)
    occupant = guess_board.get(random_row, random_column)
    if occupant == nil
      return Coordinate.new(random_row, random_column)
    else
      get_empty_coordinate
    end
  end

  def follow_up_on_hits
    hits = collect_hits
    hits.each do | hit |
      first_open_neighbor = find_open_neighbor(hit)
      return first_open_neighbor if first_open_neighbor
    end
    nil
  end

  def collect_hits
    hits = [ ] 
    data.each_with_index do | row, row_index |
      row.each_with_index do | column, column_index |
        if guess_board.get(row_index, column_index) == true
          hits.push([row_index, column_index])
        end
      end
    end
    hits
  end

  def find_open_neighbor(hit)
    neighbors = list_neighbors_within_range(hit)
    neighbors.each do | neighbor |
      if guess_board.get(neighbor[0], neighbor[1]) == nil
        return Coordinate.new(neighbor[0], neighbor[1])
      end
    end
    nil
  end

  def list_neighbors_within_range(hit)
    row = hit[0]
    column = hit[1]
    neighbors = [ ]
    neighbors.push([row - 1, column]) if (row - 1) >= 0
    neighbors.push([row, column + 1]) if (column + 1) <= 9
    neighbors.push([row + 1, column]) if (row + 1) <= 9
    neighbors.push([row, column - 1]) if (column - 1) >= 0
    neighbors
  end
  
  def data
    guess_board.data
  end

end
