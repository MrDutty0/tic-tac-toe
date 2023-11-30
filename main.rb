# frozen_string_literal: true

require_relative  'game'
require_relative  'player'

game = Game.new

(1..2).each { |id| game.add_player(Player.new(id)) }
