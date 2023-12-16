# frozen_string_literal: true

require 'colorize'

# print colored board
module BoardPrinting
  COLOR_LIGHT_GREEN = :light_green
  COLOR_RED = :red
  COLOR_YELLOW = :yellow
  COLOR_GREY = :grey

  PARTITION_LINE = '---+---+---'.colorize(COLOR_GREY)

  def display_board(curr_position, turn_symbol)
    assembled_board = get_colored_board(curr_position, turn_symbol)
                      .then(&method(:add_spaces))
                      .then(&method(:add_vertical_lines))
                      .then(&method(:add_partition_lines))

    puts assembled_board
  end

  def get_colored_board(curr_position, turn_symbol)
    turn_sym_colored = turn_symbol.colorize(COLOR_LIGHT_GREEN)

    opp_sym = (['X', 'O'] - [turn_symbol])[0]
    opp_sym_colored = opp_sym.colorize(:red)

    colored_board = clone_2d_array(board).map do |row|
      row.map do |el|
        colored_symbol = el
        colored_symbol = opp_sym_colored if opp_sym == el
        colored_symbol = turn_sym_colored if turn_symbol == el

        colored_symbol
      end
    end

    i, j = curr_position
    colored_board[i][j] = colored_board[i][j].colorize(COLOR_YELLOW)
    colored_board
  end

  def clone_2d_array(arr)
    arr.map { |row| row.map(&:dup) }
  end

  def add_spaces(board)
    board.map { |row| row.map { |el| " #{el} " } }
  end

  def add_vertical_lines(board)
    board.map { |row| row.join('|'.colorize(COLOR_GREY)) }
  end

  def add_partition_lines(board)
    board.insert(1, PARTITION_LINE)
    board.insert(3, PARTITION_LINE)

    board
  end
end
