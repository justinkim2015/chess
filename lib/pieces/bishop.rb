require_relative 'piece'
require 'pry'

class Bishop < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, i], [-i, -i], [-i, i], [i, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  def path_empty?(board, spot, piece)
    moves = find_path(piece, spot)
    moves.each do |move|
      return false if board.grid[move[0]][move[1]] != ' '
    end
    true
  end

  def find_path(start, fin, path = [])
    x = fin[0] - start[0]
    y = fin[1] - start[1]
    i = 1

    if x.positive? && y.positive?
      (x - 1).times do
        path << [start[0] + i, start[1] + i]
        i += 1
      end
    elsif x.positive? && y.negative?
      (x - 1).times do
        path << [start[0] + i, start[1] - i]
        i += 1
      end
    elsif x.negative? && y.positive?
      (abs_val(x) - 1).times do
        path << [start[0] - i, start[1] + i]
        i += 1
      end
    elsif x.negative? && y.negative?
      (abs_val(x) - 1).times do
        path << [start[0] - i, start[1] - i]
        i += 1
      end
    end
    path
  end
end
