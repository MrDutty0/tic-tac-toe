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

  def start_game_loop
    starting_player = choose_starting_player

    loop do
      start_match(starting_player)

      break unless players[0].restart?

      board.reset_board
      starting_player = retrieve_opponent(starting_player)
    end
  end

  private

  def start_match(turn_player)
    choose_player_symbols(turn_player)

    loop do
      play_round(turn_player)
      turn_player = retrieve_opponent(turn_player)

      if board.end_of_game?
        process_match_end
        PlayerIO.print_score(players)
        break
      end
    end
  end

  def choose_starting_player
    players.sample
  end

  def choose_player_symbols(starting_player)
    starting_player.assign_symbol('X')
    oponent = retrieve_opponent(starting_player)
    oponent.assign_symbol('O')
  end

  def play_round(player)
    symbol_is_placed = false
    error_message = nil
    error_count = 0
    curr_position = [1, 1]

    loop do
      PlayerIO.clear_screen
      board.display_board(curr_position)

      unless error_message.nil?
        error_count += 1
        new_error_message = error_message + " (#{error_count})"
        board.print_error_message(new_error_message)
        error_message = nil
      end

      move = player.prompt_move

      if board.arrow_keys?(move)
        curr_position = board.change_position(move, curr_position)
      elsif board.enter_key?(move)
        if board.valid_position_placement?(curr_position)
          board.place_move(curr_position, player.symbol)
          symbol_is_placed = true
        else
          error_message = 'The field is taken.'
        end
      else
        error_message = 'Choose correct key: arrow keys to navigate, enter to place symbol.'
      end

      if symbol_is_placed
        PlayerIO.clear_screen
        break
      end
    end
  end

  def process_match_end
    # can be 1d or 2d if players tied
    winner_sym_arr = board.board_winners.flatten
    winner_arr = winner_sym_arr.map { |sym| retrieve_player_from_symbol(sym) }

    if winner_arr.length == 2
      players.each(&:add_tie)
      PlayerIO.congradulate_on_tie(players)
    else
      winner = winner_arr[0]
      winner.add_win
      PlayerIO.congradulate_on_winning(winner)

      loser = retrieve_opponent(winner)
      loser.add_loss
    end
  end

  def retrieve_player_from_symbol(symbol)
    players.find { |player| player.symbol == symbol }
  end

  def retrieve_opponent(player)
    (players - [player])[0]
  end

  attr_reader :players, :exit_game, :board
end
