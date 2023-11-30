# frozen_string_literal: true

# for managing the board
class Board
  def initialize
    @game_board = Array.new(3) { Array.new(3, '_') }
  end

  private

  attr_accessor :game_board
end
