require_relative 'piece'

class Bishop < Piece
  attr_accessor :color

  def initialize(color)
    super()
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def move(board, st_x, st_y, fin_x, fin_y)
    return unless valid_move?(st_x, st_y, fin_x, fin_y) && valid_spot?(board, fin_x, fin_y)

    board.grid[fin_x][fin_y] = @color
    board.grid[st_x][st_y] = ' '
  end

  def valid_move?(st_x, st_y, fin_x, fin_y)
    i = 1
    7.times do
      return true if [fin_x, fin_y] == [st_x + i, st_y + i] && ((st_x + i) && (st_y + i)) <= 7 ||
                     [fin_x, fin_y] == [st_x - i, st_y - i] && ((st_x - i) && (st_y - i)) >= 0 ||
                     [fin_x, fin_y] == [st_x + i, st_y - i] && (st_x + i) <= 7 && (st_y - i) >= 0 ||
                     [fin_x, fin_y] == [st_x - i, st_y + i] && (st_x - i) >= 0 && (st_y + i) <= 7

      i += 1
    end
    false
  end

  def valid_spot?(board, x, y)
    enemy_pieces = if @color == 'White'
                     @black_pieces
                   else
                     @white_pieces
                   end

    return true unless enemy_pieces.include?(board.grid[x][y])

    false
  end
end
