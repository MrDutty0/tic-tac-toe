# frozen_string_literal: true

require_relative 'board'

# For managing the game: controlling Player and Board
class Game
  def initialize
    @board = Board.new
    @players = []
    @exit_game = false
  end

  def add_player(player)
    @players << player
  end

  def start_game_loop
    loop do
      start_match

      break if exit_game
    end
  end

  private

  def start_match
    turn_player = choose_starting_player
    choose_player_symbols(turn_player)
  end

  def choose_starting_player
    players.sample
  end

  def choose_player_symbols(starting_player)
    starting_player.assign_symbol('X')
    other_player = (players - [starting_player])[0]
    other_player.assign_symbol('O')
  end

  attr_reader :players, :exit_game
end
