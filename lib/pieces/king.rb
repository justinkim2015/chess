require_relative 'piece'
require 'pry'

class King < Piece
  attr_accessor :color, :location

  def initialize(color)
    super()
    @color = select_color(color)
    @in_check = false
    @location = @color == '♚' ? [7, 4] : [0, 4]
  end

  def select_color(color)
    color == 'White' ? '♚' : '♔'
  end

  def move_king(board, start, fin)
    return unless valid_move?(start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
    @location = fin
  end

  def valid_move?(start, fin)
    return true if [fin[0], fin[1]] == [start[0] - 1, start[1]] && (start[0] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1]] && (start[0] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0], start[1] + 1] && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0], start[1] - 1] && (start[1] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1] - 1] && ((start[0] + 1) <= 7 && (start[1] - 1)) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1] + 1] && (start[0] + 1) && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] - 1] && (start[0] - 1) && (start[1] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] + 1] && (start[0] - 1) >= 0 && (start[1] + 1) <= 7

    false
  end

  def pawn_checking?(board, spot)
    if @color == '♚'
      return true if board.grid[spot[0] - 1][spot[1] - 1] == '♙' ||
                     board.grid[spot[0] - 1][spot[1] + 1] == '♙'
    else
      return true if board.grid[spot[0] + 1][spot[1] + 1] == '♟' ||
                     board.grid[spot[0] + 1][spot[1] - 1] == '♟'
    end
    false
  end

  def rook_checking?(board, spot)
    i = 1
    color = @color == '♚' ? '♖' : '♜'
    7.times do
      if (spot[0] + i) <= 7 && board.grid[spot[0] + i][spot[1]] == color ||
         (spot[0] - i) >= 0 && board.grid[spot[0] - i][spot[1]] == color ||
         (spot[1] - i) >= 0 && board.grid[spot[0]][spot[1] - i] == color ||
         (spot[1] + i) <= 7 && board.grid[spot[0]][spot[1] + i] == color
        return true
      elsif (spot[0] + i) <= 7 && board.grid[spot[0] + i][spot[1]] != ' ' ||
            (spot[0] - i) >= 0 && board.grid[spot[0] - i][spot[1]] != ' ' ||
            (spot[1] - i) >= 0 && board.grid[spot[0]][spot[1] - i] != ' ' ||
            (spot[1] + i) <= 7 && board.grid[spot[0]][spot[1] + i] != ' '
        break
      end

      i += 1
    end
    false
  end

  def bishop_checking?(board, spot)
    i = 1
    color = @color == '♚' ? '♗' : '♝'
    7.times do
      if (spot[0] + i) <= 7 && (spot[1] + i) <= 7 && board.grid[spot[0] + i][spot[1] + i] == color ||
         (spot[0] - i) >= 0 && (spot[1] - i) >= 0 && board.grid[spot[0] - i][spot[1] - i] == color ||
         (spot[0] + i) <= 7 && (spot[1] - i) >= 0 && board.grid[spot[0] + i][spot[1] - i] == color ||
         (spot[0] - i) >= 0 && (spot[1] + i) <= 7 && board.grid[spot[0] - i][spot[1] + i] == color
        return true
      elsif (spot[0] + i) <= 7 && (spot[1] + i) <= 7 && board.grid[spot[0] + i][spot[1] + i] != ' ' ||
            (spot[0] - i) >= 0 && (spot[1] - i) >= 0 && board.grid[spot[0] - i][spot[1] - i] != ' ' ||
            (spot[0] + i) <= 7 && (spot[1] - i) >= 0 && board.grid[spot[0] + i][spot[1] - i] != ' ' ||
            (spot[0] - i) >= 0 && (spot[1] + i) <= 7 && board.grid[spot[0] - i][spot[1] + i] != ' '
        break
      end

      i += 1
    end
    false
  end

  # This is broken, if it goes too far out of the graph it becomes nil
  def knight_checking?(board, spot)
    color = @color == '♚' ? '♘' : '♞'
    return true if (spot[0] + 1) <= 7 && (spot[1] + 2) <= 7 && board.grid[spot[0] + 1][spot[1] + 2] == color ||
                   (spot[0] + 1) <= 7 && (spot[1] - 2) >= 0 && board.grid[spot[0] + 1][spot[1] - 2] == color ||
                   (spot[0] + 2) <= 7 && (spot[1] + 1) <= 7 && board.grid[spot[0] + 2][spot[1] + 1] == color ||
                   (spot[0] + 2) <= 7 && (spot[1] - 1) >= 0 && board.grid[spot[0] + 2][spot[1] - 1] == color ||
                   (spot[0] - 1) >= 0 && (spot[1] + 2) <= 7 && board.grid[spot[0] - 1][spot[1] + 2] == color ||
                   (spot[0] - 1) >= 0 && (spot[1] - 2) >= 0 && board.grid[spot[0] - 1][spot[1] - 2] == color ||
                   (spot[0] - 2) >= 0 && (spot[1] + 1) <= 7 && board.grid[spot[0] - 2][spot[1] + 1] == color ||
                   (spot[0] - 2) >= 0 && (spot[1] - 1) >= 0 && board.grid[spot[0] - 2][spot[1] - 1] == color

    false
  end

  def queen_checking?(board, spot)
    i = 1
    color = @color == '♚' ? '♕' : '♛'
    7.times do
      if (spot[0] + i) <= 7 && (spot[1] + i) <= 7 && board.grid[spot[0] + i][spot[1] + i] == color ||
         (spot[0] - i) >= 0 && (spot[1] - i) >= 0 && board.grid[spot[0] - i][spot[1] - i] == color ||
         (spot[0] + i) <= 7 && (spot[1] - i) >= 0 && board.grid[spot[0] + i][spot[1] - i] == color ||
         (spot[0] - i) >= 0 && (spot[1] + i) <= 7 && board.grid[spot[0] - i][spot[1] + i] == color ||
         (spot[0] + i) <= 7 && board.grid[spot[0] + i][spot[1]] == color ||
         (spot[0] - i) >= 0 && board.grid[spot[0] - i][spot[1]] == color ||
         (spot[1] - i) >= 0 && board.grid[spot[0]][spot[1] - i] == color ||
         (spot[1] + i) <= 7 && board.grid[spot[0]][spot[1] + i] == color
        return true
      elsif (spot[0] + i) <= 7 && (spot[1] + i) <= 7 && board.grid[spot[0] + i][spot[1] + i] != ' ' ||
            (spot[0] - i) >= 0 && (spot[1] - i) >= 0 && board.grid[spot[0] - i][spot[1] - i] != ' ' ||
            (spot[0] + i) <= 7 && (spot[1] - i) >= 0 && board.grid[spot[0] + i][spot[1] - i] != ' ' ||
            (spot[0] - i) >= 0 && (spot[1] + i) <= 7 && board.grid[spot[0] - i][spot[1] + i] != ' ' ||
            (spot[0] + i) <= 7 && board.grid[spot[0] + i][spot[1]] != ' ' ||
            (spot[0] - i) >= 0 && board.grid[spot[0] - i][spot[1]] != ' ' ||
            (spot[1] - i) >= 0 && board.grid[spot[0]][spot[1] - i] != ' ' ||
            (spot[1] + i) <= 7 && board.grid[spot[0]][spot[1] + i] != ' '
        break
      end

      i += 1
    end
    false
  end

  def king_in_check?(board, spot)
    return true if pawn_checking?(board, spot) ||
                   knight_checking?(board, spot) ||
                   bishop_checking?(board, spot) ||
                   queen_checking?(board, spot) ||
                   rook_checking?(board, spot)

    false
  end
end
