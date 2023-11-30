# frozen_string_literal: true

# checks if the game has won and by whom
module GameEndChecking
  def board_winners
    [horizontal_winner || vertical_winner || diagonal_winner || tie_winner].compact
  end

  def check_line(line)
    line.first if line.all? { |sym| sym == 'X' } || line.all? { |sym| sym == 'O' }
  end

  def horizontal_winner
    board.each do |row|
      result = check_line(row)
      return result if result
    end
    nil
  end

  def vertical_winner
    board.transpose.each do |column|
      result = check_line(column)
      return result if result
    end
    nil
  end

  def tie_winner
    ['O', 'X'] if board.flatten.all? { |sym| sym != '_' }
  end

  def diagonal_winner
    ans = check_line(board.map.with_index { |_, ind| board[ind][ind] })
    ans || check_line(board.map.with_index { |_, ind| board[2 - ind][ind] })
  end
end
