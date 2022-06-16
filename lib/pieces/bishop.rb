require './lib/pieces/piece'

class Bishop < Piece
  attr_accessor :color

  def initialize(color)
    super()
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def move(board, x, y)
    unless @white_pieces.include?(board.grid[x][y])
      board.grid[x][y] = @color
    end
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

  # What color is my bishop class in my test case??
  def valid_spot?(board, x, y)
    pieces = if @color == 'White'
               @white_pieces
             else
               @black_pieces
             end

    return true unless pieces.include?(board.grid[x][y])

    false
  end
end
