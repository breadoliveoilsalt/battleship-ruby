require_relative './ship_segment.rb'

class ConsoleUserInterface

  attr_reader :output_stream, :input_stream, :prior_guess_result

  def initialize(output_stream:, input_stream:)
    @output_stream = output_stream
    @input_stream = input_stream
    @status = ""
  end

  def clear_view
    system("cls") || system("clear")
  end

  def show_welcome
    clear_view
    str = <<~HEREDOC
          -----------------------------------------------------




                     *** Welcome to Battleship! ***

                       (Press any key to continue)





          -----------------------------------------------------

    HEREDOC
    output_stream.render(str)
    input_stream.read_char
  end

  def show_potential_fleet_board(fleet_board)
    clear_view
    str = line
    str += "|                          FLEET BOARD                            |\n" 
    str += line
    str += "|     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |\n"
    str += line
    (0...fleet_board.data.length).each do | row |
      str += stringify_fleet_board_row(row, fleet_board) + "\n" + line
    end
    output_stream.render(str)
  end

  def show_game(guess_board, fleet_board)
    clear_view
    str = double_line
    str += "|                          GUESS BOARD                            | * |                          FLEET BOARD                            |\n" 
    str += double_line
    str += "|     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  | * |     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |\n"
    str += double_line
    (0...fleet_board.data.length).each do | row |
      str += stringify_guess_board_row(row, guess_board)
      str += " * "
      str += stringify_fleet_board_row(row, fleet_board)
      str += "\n"
      str += double_line
    end
    str += "              Unsunk Ships                  Sunk Ships                              Unsunk Ships                  Sunk Ships \n"
    str += "              ------------                  ----------                              ------------                  ---------- \n"
    str += stringify_ships_list(guess_board, fleet_board)
    str += double_line
    str += "Status: \n"
    str += @status
    output_stream.render(str)
  end
  
  def stringify_guess_board_row(row, guess_board)
    str = "|  #{row_to_string(row)}  |"
    guess_board.data[row].each do | column |
      str += guess_board_column_value_to_string(column) 
    end
    str
  end

  def guess_board_column_value_to_string(column)
    if column == true
      "  \e[31m#{"X"}\e[0m  |"
    elsif column == false
      "  \e[36m#{"-"}\e[0m  |"
    else
      "     |"
    end
  end

  def stringify_fleet_board_row(row, fleet_board)
    str = "|  #{row_to_string(row)}  |"
    fleet_board.data[row].each do | column |
      str += fleet_board_column_value_to_string(column)
    end
    str
  end

  def row_to_string(row)
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"][row]
  end
  
  def fleet_board_column_value_to_string(column)
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
  
  def line
    "|-----------------------------------------------------------------|\n"
  end

  def double_line
    "|-----------------------------------------------------------------| * |-----------------------------------------------------------------|\n"
  end

  def stringify_ships_list(guess_board, fleet_board)
    str = ""
    (0..4).each do | index |
      unsunk_guess_board_ship = stringify_unsunk_ship(guess_board.unsunk_ships[index])
      sunk_guess_board_ship = stringify_sunk_ship(guess_board.sunk_ships[index])
      unsunk_fleet_board_ship = stringify_unsunk_ship(fleet_board.unsunk_ships[index])
      sunk_fleet_board_ship = stringify_sunk_ship(fleet_board.sunk_ships[index])
      str += leading_spaces + unsunk_guess_board_ship + sunk_guess_board_ship + unsunk_fleet_board_ship + sunk_fleet_board_ship + "\n"
    end
    str 
  end

  def leading_spaces
    "              "
  end

  def padding_for_unsunk_ship
    30
  end

  def padding_for_sunk_ship
    40
  end
  
  def spaces_in_lieu_of_unsunk_ship
    str = ""
    padding_for_unsunk_ship.times { str += " " }
    str
  end

  def spaces_in_lieu_of_sunk_ship
    str = ""
    padding_for_sunk_ship.times { str += " " }
    str
  end

  def stringify_unsunk_ship(unsunk_ship_string)
    if unsunk_ship_string
      padding = padding_for_unsunk_ship - unsunk_ship_string.length
      padding.times { unsunk_ship_string += " " }
      unsunk_ship_string
    else
      spaces_in_lieu_of_unsunk_ship
    end
  end

  def stringify_sunk_ship(sunk_ship_string)
    if sunk_ship_string
      padding = padding_for_sunk_ship - sunk_ship_string.length
      padding.times { sunk_ship_string += " " }
      sunk_ship_string
    else
      spaces_in_lieu_of_sunk_ship
    end
  end

  def get_board_ok
    output_stream.render("\nWould you like your ships placed in this way? (Type 'y' or 'n')\n")
    decision = input_stream.read_char
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
    output_stream.render("\nPlease enter a row from 'a' to 'j'.\n")
    row = input_stream.read_char
    validate_row(row)
  end

  def validate_row(row)
    if row_within_range?(row)
      row_to_data(row)
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_row
    end
  end
  
  def row_within_range?(row)
    row.length == 1 && row >= "a" && row <= "j"
  end

  def row_to_data(row)
    {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7, i: 8, j: 9}[row.to_sym]
  end
  
  def column_to_string(column)
    (column + 1).to_s
  end
  
  def get_column
    output_stream.render("\nPlease select a column from '1' to '10' and hit enter.\n")
    column = input_stream.read_line
    validate_column(column)
  end

  def validate_column(column)
    if column_within_range?(column)
      column_to_data(column)
    else
      output_stream.render("\nSorry, invalid selection.\n")
      get_column
    end
  end
  
  def column_within_range?(column)
    column.to_i >= 1 && column.to_i <= 10
  end

  def column_to_data(column)
    column.to_i - 1
  end
  
  def record_result_of_guess(coordinate_guess, guess_response)
    row = coordinate_guess.row
    column = coordinate_guess.column
    if guess_response.hit?
      @status = "\nYour guess of #{row_to_string(row)}#{column_to_string(column)} was a hit!\n"
    else
      @status = "\nYour guess of #{row_to_string(row)}#{column_to_string(column)} was a miss!\n"
    end

    if guess_response.ship_sunk?
       @status += "\n** You sunk the computer's #{guess_response.ship_type}! **\n"
    end
  end

  def record_response(coordinate_guess, guess_response)
    row = coordinate_guess.row
    column = coordinate_guess.column

    if guess_response.hit?
      @status += "\nThe Computer Player guessed #{row_to_string(row)}#{column_to_string(column)} and got a hit!\n"
      @status += "\n** The Computer Player sunk your #{guess_response.ship_type}! **\n" if guess_response.ship_sunk?
    else
      @status += "\nThe Computer Player guessed #{row_to_string(row)}#{column_to_string(column)} and missed!\n"
    end
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
