# frozen_string_literal: true

require 'colorize'

# print colored board
module BoardPrinting
  COLOR_GREEN = :green
  COLOR_RED = :red
  COLOR_GREY = :grey
  COLOR_LIGHT_WHITE = :light_white
  COLORED_CROSS = 'X'.colorize(COLOR_GREEN)
  COLORED_NOUGHT = 'O'.colorize(COLOR_RED)

  PARTITION_LINE = '---+---+---'.colorize(COLOR_GREY)

  def display_board(curr_position)
    assembled_board = get_colored_board(curr_position)
                      .then(&method(:add_spaces))
                      .then(&method(:add_vertical_lines))
                      .then(&method(:add_partition_lines))

    puts assembled_board
  end

  def get_colored_board(curr_position)
    mappings = { 'X' => COLORED_CROSS, 'O' => COLORED_NOUGHT }

    colored_board = clone_2d_array(board).map do |row|
      row.map { |el| mappings.fetch(el, el) }
    end

    i, j = curr_position
    colored_board[i][j] = colored_board[i][j].colorize(background: COLOR_LIGHT_WHITE)
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
