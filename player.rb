# frozen_string_literal: true

require_relative 'player_io'

# Class for player of the game
class Player
  include PlayerIO

  attr_reader :symbol, :score, :name

  def initialize(id)
    @name = prompt_name(id)
    @symbol = nil
    @score = { wins: 0, loses: 0, ties: 0 }
  end

  def assign_symbol(symbol_to_set)
    @symbol = symbol_to_set
  end

  def add_tie
    score[:ties] += 1
  end

  def add_loss
    score[:loses] += 1
  end

  def add_win
    score[:wins] += 1
  end

  private

  attr_writer :score
end
