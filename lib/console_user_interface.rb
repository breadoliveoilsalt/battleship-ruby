require_relative './ship_segment.rb'

class ConsoleUserInterface

  attr_reader :output_stream, :input_stream, :prior_guess_result

  def initialize(output_stream:, input_stream:)
    @output_stream = output_stream
    @input_stream = input_stream
    @prior_guess_result = nil
  end

  def show_potential_fleet_board(fleet_board)
    system("cls") || system("clear")
    show_fleet_board(fleet_board)
  end

  def get_board_ok
    output_stream.render("\nWould you like your ships placed in this way? (Enter 'y' or 'n')\n")
    decision = input_stream.read_line
    validate_board_ok_decision(decision)
  end

  def validate_board_ok_decision(decision)
    if decision == 'y' 
      true
    elsif decision == 'n'
      false
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_board_ok
    end
  end

  def get_row
    output_stream.render("\nPlease select a row from 'a' to 'j'\n")
    row = input_stream.read_line
    validate_row(row)
  end

  def validate_row(row)
    if row_within_range?(row)
      row
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_row
    end
  end
  
  def row_within_range?(row)
    row.length == 1 && row >= "a" && row <= "j"
  end
  
  def get_column
    output_stream.render("\nPlease select a column from '1' to '10'\n")
    column = input_stream.read_line
    validate_column(column)
  end

  def validate_column(column)
    if column_within_range?(column)
      column
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_column
    end
  end
  
  def column_within_range?(column)
    column.to_i >= 1 && column.to_i <= 10
  end
  
  def record_result_of_guess(coordinate_guess, guess_response)
    row = coordinate_guess.row
    column = coordinate_guess.column
    if guess_response.hit?
      @prior_guess_result = "\n#{row}#{column} was a hit!\n"
    else
      @prior_guess_result = "\n#{row}#{column} was a miss!\n"
    end
  end
  
  def clear_view
    system("cls") || system("clear")
  end

  def show_guess_board(guess_board_data)
    str =   "                             GUESS BOARD                          \n"
    str += line_break
    str +=  "     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |\n"
    str += line_break
    guess_board_data.data.each do | row, columns |
      str += "  #{row}  |"
      columns.each do | column |
        str += column_value_to_string(column)
      end
      str += "\n" + line_break
    end
    output_stream.render(str)
    output_stream.render(@prior_guess_result)
  end

  def column_value_to_string(column)
    if column == true
      "  \e[31m#{"X"}\e[0m  |"
    elsif column == false
      "  \e[36m#{"-"}\e[0m  |"
    else
      "     |"
    end
  end

  def show_fleet_board(fleet_board)
    str =   "                              FLEET BOARD                          \n"
    str += line_break
    str +=  "\n     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |\n"
    str += line_break
    fleet_board.data.each do | row, columns |
      str += "  #{row}  |"
      columns.each do | column |
        str += fleet_column_value_to_string(column)
      end
      str += "\n" + line_break
    end
    output_stream.render(str)
  end

  def fleet_column_value_to_string(column)
    if column.is_a?(ShipSegment)
      segment_string = "[#{column.ship.type[0]}]"
      if column.hit?
        " \e[31m#{segment_string}\e[0m |"
      else  
        " #{segment_string} |"
      end
    elsif column == false
      "  \e[36m#{"-"}\e[0m  |"
    else
      "     |"
    end
  end

  def line_break
    "------------------------------------------------------------------\n"
  end
  
  def announce_winner(winner)
    if winner.is_a?(HumanPlayer)
      output_stream.render("\nCongratulations! You won!\n")
    else
      output_stream.render("\nSorry, the other player sunk all your ships.\n")
    end
  end

  def get_play_again
    output_stream.render("\nWould you like to play again? (Enter 'y' or 'n')\n")
    decision = input_stream.read_line
    validate_play_again_decision(decision)
  end
  
  def validate_play_again_decision(decision)
    if decision == 'y' 
      true
    elsif decision == 'n'
      false
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_play_again
    end
  end

  def good_bye
    output_stream.render("\nThanks for playing! Good bye!\n")
  end
end
