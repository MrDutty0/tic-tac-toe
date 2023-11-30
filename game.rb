# frozen_string_literal: true

require_relative 'board'

# For managing the game: controlling Player and Board
class Game
  def initialize
    @board = Board.new
    @players = []
  end

  def add_player(player)
    @players << player
  end

  private

  attr_reader :players
end
