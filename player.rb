# frozen_string_literal: true

require_relative 'promptable'

# Class for player of the game
class Player
  include Promptable

  def initialize(id)
    @name = prompt_name(id)
  end

  private

  attr_reader :name
end
