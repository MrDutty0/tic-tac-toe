# frozen_string_literal: true

require_relative 'game_end_checking'
require_relative 'board_printing'
require_relative 'move_processor'

# for managing the board
class Board
  include GameEndChecking
  include BoardPrinting
  include MoveProcessor

  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3, '_') }
  end

  def end_of_game?
    !board_winners.empty?
  end

  def print_error_message(message)
    print "#{message}\n"
  end

  def place_move(move, symbol)
    i, j = move
    board[i][j] = symbol
  end

  def reset_board
    @board = Array.new(3) { Array.new(3, '_') }
  end
end
