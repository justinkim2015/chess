require_relative 'piece'
require 'pry'

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

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, 0], [-i, 0], [0, i], [0, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  def find_path(start, fin, path = [])
    x = fin[0] - start[0]
    y = fin[1] - start[1]
    i = 1

    if x.positive?
      (x - 1).times do
        path << [start[0] + i, start[1]]
        i += 1
      end
    elsif x.negative?
      (abs_val(x) - 1).times do
        path << [start[0] - i, start[1]]
        i += 1
      end
    elsif y.positive?
      (y - 1).times do
        path << [start[0], start[1] + i]
        i += 1
      end
    elsif y.negative?
      (abs_val(y) - 1).times do
        path << [start[0], start[1] - i]
        i += 1
      end
    end
    path
  end
end