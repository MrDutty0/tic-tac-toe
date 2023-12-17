# frozen_string_literal: true

require 'io/console'

# Checks types of moves
module MoveProcessor
  def arrow_keys?(move)
    ["\e[A", "\e[B", "\e[C", "\e[D"].include?(move)
  end

  def enter_key?(move)
    move == "\r"
  end

  def change_position(move, curr_position)
    i, j = curr_position

    case move
    when "\e[A"
      i -= i.zero? ? -2 : 1
    when "\e[B"
      i += i == 2 ? -2 : 1
    when "\e[C"
      j += j == 2 ? -2 : 1
    else
      j -= j.zero? ? -2 : 1
    end
    [i, j]
  end

  def valid_position_placement?(position)
    i, j = position
    board[i][j] == '_'
  end
end
