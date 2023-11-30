# frozen_string_literal: true

require_relative 'game_end_checking'

# for managing the board
class Board
  include GameEndChecking

  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3, '_') }
  end

  def end_of_game?
    !board_winners.empty?
  end
end
