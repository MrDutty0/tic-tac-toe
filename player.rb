# frozen_string_literal: true

require_relative 'promptable'

# Class for player of the game
class Player
  include Promptable

  def initialize(id)
    @name = prompt_name(id)
    @symbol = nil
    @score = { wins: 0, loses: 0, ties: 0 }
  end

  def assign_symbol(symbol_to_set)
    @symbol = symbol_to_set
  end

  private

  attr_reader :name
end
