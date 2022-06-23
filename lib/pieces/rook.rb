require_relative 'piece'

class Rook < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♜' : '♖'
  end

  def move(board, start, fin)
    return unless valid_move?(start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
  end

  def valid_move?(start, fin)
    i = 1
    7.times do
      return true if [fin[0], fin[1]] == [start[0] + i, start[1]] ||
                     [fin[0], fin[1]] == [start[0] - i, start[1]] ||
                     [fin[0], fin[1]] == [start[0], start[1] - i] && (start[1] - i) >= 0 ||
                     [fin[0], fin[1]] == [start[0], start[1] + i] && (start[1] + i) <= 7

      i += 1
    end
    false
  end
end

# valid_moves = [[spot_x + i, spot_y],
#                [spot_x - i, spot_y],
#                [spot_x, spot_y + i],
#                [spot_x, spot_y - i]]
